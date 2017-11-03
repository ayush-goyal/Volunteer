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

    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        /*
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        */
        
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.dismissDetail))
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.title = "Event"
        
        changeButtonState()
        
        //Change font weights and style
        
        nameLabel.font = UIFont(name: "Nunito-Bold", size: 23.0)!
        organizerLabel.font = UIFont(name: "Nunito-SemiBold", size: 20.0)!
    }
    
    func dismissDetail() {
        navigationController?.popViewController(animated: true)
    }
    
    /*func fetchSavedEventByID(eventID: Int) -> SavedEvent? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedEvent")
        fetchResult.predicate = NSPredicate(format: "eventID == \(eventID)")
        do {
            let fetchedResults = try managedObjectContext.fetch(fetchResult)
        } catch {
            print ("Fetched task failed for ID: \(error)")
        }
        
    }*/
    
    func configureView() {
        nameLabel.text = event.name
        organizerLabel.text = event.organizer
        descriptionLabel.text = event.information
        locationLabel.text = event.location
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let startDate = dateFormatter.string(from: event.startDate)
        
        if let endDate = event.endDate {
            dateLabel.text = "\(startDate) - \(dateFormatter.string(from: endDate))"
        } else {
            dateLabel.text = startDate
        }
    }
    
    @IBAction func saveEvent(_ sender: Any) {
        if event.isSaved == false {
        
            let savedEvent = NSEntityDescription.insertNewObject(forEntityName: "SavedEvent", into: managedObjectContext) as! SavedEvent
            savedEvent.name = event.name
            savedEvent.organizer = event.organizer
            savedEvent.information = event.information
            savedEvent.startDate = event.startDate
            savedEvent.endDate = event.endDate
            savedEvent.latitude = event.coordinate.latitude
            savedEvent.longitude = event.coordinate.longitude
            savedEvent.link = event.link
            savedEvent.location = event.location
            savedEvent.eventID = Int32(event.eventID)
            
            managedObjectContext.saveChanges()
            
            event.savedEvent = savedEvent
            event.isSaved = true
            changeButtonState()
        } else {
            managedObjectContext.delete(event.savedEvent!)
            managedObjectContext.saveChanges()
            
            event.isSaved = false
            changeButtonState()
        }
    }
    
    func changeButtonState() {
        if event.isSaved {
            saveButton.backgroundColor = UIColor(red: 255.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0)
            saveButton.setTitle("Leave Event", for: .normal)
        } else {
            saveButton.backgroundColor = UIColor(red: 122.0/255.0, green: 255.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            saveButton.setTitle("Sign Up for Event", for: .normal)
        }
    }
}
