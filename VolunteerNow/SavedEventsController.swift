//
//  SavedEventsController.swift
//  VolunteerNow
//
//  Created by Macbook on 10/24/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit
import CoreData

class SavedEventsController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: SavedEventFetchedResultsController = {
        return SavedEventFetchedResultsController(managedObjectContext: self.managedObjectContext, tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedEvent", for: indexPath)
        
        let savedEvent = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = savedEvent.name
        cell.detailTextLabel?.text = savedEvent.organizer

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let eventDetailController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetailController") as? EventDetailController {
            
            for event in eventsData {
                let eventID = event.eventID
                let savedEvent = fetchedResultsController.object(at: indexPath)
                let savedEventID = savedEvent.eventID
                
                if eventID == savedEventID {
                    eventDetailController.event = event
                    eventDetailController.managedObjectContext = managedObjectContext
                    navigationController?.pushViewController(eventDetailController, animated: true)
                }
            }
        }
    }

}
