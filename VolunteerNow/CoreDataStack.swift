//
//  CoreDataStack.swift
//  VolunteerNow
//
//  Created by Macbook on 10/24/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import CoreData
import Foundation

class CoreDataStack {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VolunteerNow")
        container.loadPersistentStores() { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let container = self.persistentContainer
        return container.viewContext
    }()
    
}

extension NSManagedObjectContext {
    func saveChanges() {
        if self.hasChanges {
            do {
                try save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}











