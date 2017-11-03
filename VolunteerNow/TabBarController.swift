//
//  TabBarController.swift
//  VolunteerNow
//
//  Created by Abhinav Piplani on 11/1/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit
import CoreData

class TabBarController: UITabBarController {
    
    let coreDataStack = CoreDataStack()
    lazy var managedObjectContext: NSManagedObjectContext = {
        self.coreDataStack.managedObjectContext
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let tabBarViewControllers = self.viewControllers {
            if let navigationControllerForContainerSearchController = tabBarViewControllers[0] as? UINavigationController, let containerSearchController = navigationControllerForContainerSearchController.topViewController as? ContainerSearchController {
                containerSearchController.managedObjectContext = self.managedObjectContext
            }
            if let navigationControllerForSavedEventsController = tabBarViewControllers[1] as? UINavigationController, let savedEventsController = navigationControllerForSavedEventsController.topViewController as? SavedEventsController {
                savedEventsController.managedObjectContext = self.managedObjectContext
            }
            
        }
        
        let accountItem = self.tabBar.items![2]
        accountItem.title = "Account"
        var accountImage = UIImage(named: "account")!.withRenderingMode(.alwaysTemplate)
        accountItem.image = accountImage
        accountItem.selectedImage = UIImage(named: "account_selected.png")!.withRenderingMode(.alwaysTemplate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}

