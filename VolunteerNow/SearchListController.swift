//
//  SearchListController.swift
//  VolunteerNow
//
//  Created by Macbook on 10/14/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class SearchListController: UITableViewController, CLLocationManagerDelegate {

    var currentLocation: CLLocation?
    var locationManager: CLLocationManager = CLLocationManager()
    var delegate: RequestEventsDataDelegate?
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        //locationManager.startUpdatingLocation()
        
        if let temporaryLocation = locationManager.location?.coordinate {
            currentLocation = CLLocation(latitude: temporaryLocation.latitude, longitude: temporaryLocation.longitude)
        }
        
        calculateEventDistances()
        
    }
    
    func calculateEventDistances() {
        //print("Current Location")
        //print(currentLocation)
        for event in eventsData {
            let distanceInCLLocation = CLLocation(latitude: event.coordinate.latitude, longitude: event.coordinate.longitude)
            if let distance = currentLocation?.distance(from: distanceInCLLocation) {
                let distanceInMiles = (distance * 10/1609.34).rounded() / 10.0 // Gives one decimal point precision
                event.distance = distanceInMiles
            }
        }
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
    //MARK: - CoreLocation Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        let locationValue: CLLocationCoordinate2D = manager.location!.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(currentLocation)
        delegate?.requestData()
        calculateEventDistances()
        updateView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventCell else { fatalError() }

        cell.eventName.text = eventsData[indexPath.row].name
        cell.eventOrganizer.text = eventsData[indexPath.row].organizer
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let startDate = dateFormatter.string(from: eventsData[indexPath.row].startDate)
        
        if let endDate = eventsData[indexPath.row].endDate {
            cell.eventDate.text = "\(startDate) - \(dateFormatter.string(from: endDate))"
        } else {
            cell.eventDate.text = startDate
        }
        
        //cell.eventDistance.text = eventsData[indexPath.row].distance ?? eventsData[indexPath.row].location
        /*
        let distanceInCLLocation = CLLocation(latitude: eventsData[indexPath.row].coordinate.latitude, longitude: eventsData[indexPath.row].coordinate.longitude)
        if let distance = currentLocation?.distance(from: distanceInCLLocation) {
            let distanceInMiles = (distance * 10/1609.34).rounded() / 10.0 // Gives one decimal point precision
            eventsData[indexPath.row].distance = distanceInMiles
            let distanceInText = String(format:"%.1f", distanceInMiles) + " miles"
            cell.eventDistance.text = distanceInText
            print(distance)
        } else {
            cell.eventDistance.text = eventsData[indexPath.row].location
        }*/
        
        if let distance = eventsData[indexPath.row].distance {
            let distanceInText = String(format:"%.1f", distance) + " miles"
            cell.eventDistance.text = distanceInText
        } else {
            cell.eventDistance.text = eventsData[indexPath.row].location
        }
        
        return cell
        
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let eventDetailController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetailController") as? EventDetailController {
            eventDetailController.event = eventsData[indexPath.row]
            eventDetailController.managedObjectContext = managedObjectContext
            //present(eventDetailController, animated: true, completion: nil)
            navigationController?.pushViewController(eventDetailController, animated: true)
        }
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEventDetail" {
            if let eventDetailController = segue.destination as? EventDetailController {
                let path = tableView.indexPathForSelectedRow!
                eventDetailController.event = eventsData[path.row]
                eventDetailController.managedObjectContext = managedObjectContext
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let fifthToLastElement = eventsData.count - 5
        if indexPath.row == fifthToLastElement {
            delegate?.requestData()
        }
    }

    
    // MARK: - Navigation

    @IBAction func returnToEventList(_ segue: UIStoryboardSegue) {
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEventDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let event = eventsData[indexPath.row]
                
                if let navigationController = segue.destination as? UINavigationController, let eventDetailController = navigationController.topViewController as? EventDetailController {
                    eventDetailController.event = event
                }
            
            }
        }
    }
    */

}
