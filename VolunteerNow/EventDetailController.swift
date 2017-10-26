//
//  EventDetailController.swift
//  VolunteerNow
//
//  Created by Macbook on 10/21/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit
import CoreData

class EventDetailController: UIViewController {
    
    var event: Event!
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var organizerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        /*
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        */
        
        navigationItem.title = "Event"
    }
    
    func configureView() {
        nameLabel.text = event.name
        organizerLabel.text = event.organizer
        descriptionLabel.text = event.information
        dateLabel.text = event.date
        locationLabel.text = event.location
    }
    
    @IBAction func saveEvent(_ sender: Any) {
        let savedEvent = NSEntityDescription.insertNewObject(forEntityName: "SavedEvent", into: managedObjectContext) as! SavedEvent
        savedEvent.name = event.name
        savedEvent.organizer = event.organizer
        savedEvent.information = event.information
        savedEvent.date = event.date
        savedEvent.latitude = event.coordinate.latitude
        savedEvent.longitude = event.coordinate.longitude
        savedEvent.link = event.link
        savedEvent.location = event.location
        
        managedObjectContext.saveChanges()
    }
}
