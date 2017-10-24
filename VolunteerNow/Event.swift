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
    var date: String
    var location: String
    var distance: String?
    var information: String
    var coordinate: CLLocationCoordinate2D
    
    init?(data: [String: Any]) {
        guard let name = data["name"] as? String, let organizer = data["organizer"] as? String, let date = data["date"] as? String, let location = data["location"] as? String, let description = data["description"] as? String, let coordinate = data["coordinate"] as? [String: CLLocationDegrees] else {
            return nil
        }
        
        self.name = name
        self.title = name
        self.organizer = organizer
        self.date = date
        self.location = location
        self.information = description
        guard let latitude = coordinate["latitude"], let longitude = coordinate["longitude"] else {
            return nil }
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}












