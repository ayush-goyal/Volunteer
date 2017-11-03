//
//  BarSearchController.swift
//  VolunteerNow
//
//  Created by Macbook on 10/14/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class BarSearchController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate  {
    
    var searchController : UISearchController!
    var searchBar: UISearchBar!
    var filteredEventsData: [Event] = []
    var managedObjectContext: NSManagedObjectContext!
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchBar = searchController.searchBar
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.titleView = searchController.searchBar

        self.definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil && searchBar.text != "" {
            //filteredEventsData
        }
    }
    
    //MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredEventsData = eventsData.filter({( event: Event ) -> Bool in
            return event.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEventsData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(filteredEventsData)
        print(indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchEventCell", for: indexPath) as? SearchEventCell else { fatalError() }
        
        
        cell.eventName.text = filteredEventsData[indexPath.row].name
        cell.eventOrganizer.text = filteredEventsData[indexPath.row].organizer
        
        
        
        let distanceInCLLocation = CLLocation(latitude: filteredEventsData[indexPath.row].coordinate.latitude, longitude: filteredEventsData[indexPath.row].coordinate.longitude)
        if let distance = currentLocation?.distance(from: distanceInCLLocation) {
            let distanceInMiles = (distance * 10/1609.34).rounded() / 10.0 // Gives one decimal point precision
            let distanceInText = String(format:"%.1f", distanceInMiles) + " miles"
            cell.eventDistance.text = distanceInText
            print(distance)
        } else {
            cell.eventDistance.text = filteredEventsData[indexPath.row].location
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let eventDetailController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetailController") as? EventDetailController {
            for event in eventsData {
                let eventID = event.eventID
                let filteredEvent = filteredEventsData[indexPath.row]
                let filteredEventID = filteredEvent.eventID
                
                if eventID == filteredEventID {
                    eventDetailController.event = event
                    eventDetailController.managedObjectContext = managedObjectContext
                    navigationController?.pushViewController(eventDetailController, animated: true)
                }
            }
        }
    }
    
}
