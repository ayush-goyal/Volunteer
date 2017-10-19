//
//  Event.swift
//  VolunteerNow
//
//  Created by Macbook on 10/15/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import Foundation


class Event {
    let name: String
    let organizer: String
    let date: String
    let location: String
    
    init?(data: [String: String]) {
        guard let name = data["name"], let organizer = data["organizer"], let date = data["date"], let location = data["location"] else {
            return nil
        }
        
        self.name = name
        self.organizer = organizer
        self.date = date
        self.location = location
    }
}












