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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedEvent> {
        let request = NSFetchRequest<SavedEvent>(entityName: "SavedEvent")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }

    @NSManaged public var information: String?
    @NSManaged public var link: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var organizer: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var date: String?

}
