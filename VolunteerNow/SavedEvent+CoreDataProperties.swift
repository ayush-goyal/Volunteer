//
//  SavedEvent+CoreDataProperties.swift
//  VolunteerNow
//
//  Created by Macbook on 10/24/17.
//  Copyright © 2017 Ayush. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedEvent {

    // Helper function to get fetch request for saved events, sort descriptors are also called here
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedEvent> {
        let request = NSFetchRequest<SavedEvent>(entityName: "SavedEvent")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }

    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date?
    @NSManaged public var information: String?
    @NSManaged public var latitude: Double
    @NSManaged public var link: String?
    @NSManaged public var location: String?
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var organizer: String?
    @NSManaged public var eventID: Int32

}
