//
//  AppDelegate.swift
//  VolunteerNow
//
//  Created by Macbook on 10/14/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Initializes core data stack and managed object context to use in rest of application
    /*
    let coreDataStack = CoreDataStack()
    lazy var managedObjectContext: NSManagedObjectContext = {
        self.coreDataStack.managedObjectContext
    }()*/

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Call if needed to remove all core data records
        //deleteAllCoreDataRecords()
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 53.0/255.0, green: 85.0/255.0, blue: 130.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        /*let tabBarController = window!.rootViewController as! UITabBarController
        
        // Gets initial views from tab bar controller and sets managed object context with dependency injection to keep context consistent across views
        if let tabBarViewControllers = tabBarController.viewControllers {
            if let navigationControllerForContainerSearchController = tabBarViewControllers[0] as? UINavigationController, let containerSearchController = navigationControllerForContainerSearchController.topViewController as? ContainerSearchController {
                containerSearchController.managedObjectContext = self.managedObjectContext
            }
            
            if let navigationControllerForSavedEventsController = tabBarViewControllers[1] as? UINavigationController, let savedEventsController = navigationControllerForSavedEventsController.topViewController as? SavedEventsController {
                savedEventsController.managedObjectContext = self.managedObjectContext
            }
            
        }*/
        
        // Change default font
        UILabel.appearance().font = UIFont(name: "Nunito-Regular", size: 17.0)
        //print(UIFont.fontNames(forFamilyName: "Nunito"))
        
        // Change tab bar defaults
        let semiBoldFont = UIFont(name: "Nunito-SemiBold", size: 11.0)!
        let tabBarAttributesNormal = [NSFontAttributeName: semiBoldFont]
        let blackFont = UIFont(name: "Nunito-Black", size: 11.0)!
        let tabBarAttributesSelected = [NSFontAttributeName: blackFont, NSForegroundColorAttributeName: UIColor(red: 53.0/255.0, green: 85.0/255.0, blue: 130.0/255.0, alpha: 1.0)]
        
        UITabBarItem.appearance().setTitleTextAttributes(tabBarAttributesNormal, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(tabBarAttributesSelected, for: .selected)

        //Change segmented control defaults
        let segmentedControlAttributes = [NSFontAttributeName: UIFont(name: "Nunito-Bold", size: 14.0)!, NSForegroundColorAttributeName: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(segmentedControlAttributes, for: .normal)
        
        
        //Change initial view controller
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeController = storyboard.instantiateViewController(withIdentifier: "welcomeController")
        window?.rootViewController = welcomeController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    /*func deleteAllCoreDataRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedEvent")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch {
            print ("Error deleting all core data records in SavedEvent")
        }
    }*/

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        //managedObjectContext.saveChanges()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        //managedObjectContext.saveChanges()
    }


}

