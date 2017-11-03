//
//  EventAnnotation.swift
//  VolunteerNow
//
//  Created by Macbook on 10/22/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import MapKit

class EventAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
}
