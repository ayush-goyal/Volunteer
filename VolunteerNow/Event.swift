//
//  Event.swift
//  VolunteerNow
//
//  Created by Macbook on 10/15/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import CoreLocation
import MapKit

class Event: NSObject, MKAnnotation {
    var name: String
    var title: String?
    var organizer: String
    var startDate: Date
    var endDate: Date?
    var location: String
    var distance: Double?
    var information: String
    var coordinate: CLLocationCoordinate2D
    var link: String
    var isSaved: Bool = false
    var savedEvent: SavedEvent?
    var eventID: Int
    
    init?(data: [String: Any]) {
        guard let name = data["name"] as? String, let organizer = data["organizer"] as? String, let date = data["date"] as? String, let location = data["location"] as? String, let description = data["description"] as? String, let coordinate = data["coordinate"] as? [String: CLLocationDegrees], let link = data["link"] as? String, let eventID = data["eventID"] as? String else {
            return nil
        }
        
        self.name = name
        self.title = name
        self.organizer = organizer
        self.location = location
        self.information = description
        self.link = link
        self.eventID = Int(eventID) ?? 0
        guard let latitude = coordinate["latitude"], let longitude = coordinate["longitude"] else {
            return nil }
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if date.count > 10 {
            var index = date.index(date.startIndex, offsetBy:10)
            self.startDate = dateFormatter.date(from: date.substring(to: index))!
            
            index = date.index(date.startIndex, offsetBy:13)
            self.endDate = dateFormatter.date(from: date.substring(from: index))!
        } else {
            self.startDate = dateFormatter.date(from: date)!
        }
        
    }
    
}












