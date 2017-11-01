//
//  ContainerSearchController.swift
//  VolunteerNow
//
//  Created by Macbook on 10/14/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

var eventsData: [Event] = []

protocol RequestEventsDataDelegate {
    func requestData()
    var serverRequestEventsDataURL: String { get }
}

class ContainerSearchController: UIViewController, RequestEventsDataDelegate {
    
    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
    var section: String = "1"
    var location: String = "Marietta GA"
    var isRequestingData = false
    let serverRequestEventsDataURL = "https://fddffcab.ngrok.io/events"
    var managedObjectContext: NSManagedObjectContext!
    
    var selectedCategory: CategoryTypes = .all
    var selectedSort: SortTypes = .relevance
    
    override func viewDidLoad() {
        requestData()
        print(managedObjectContext)
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchListComponent")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        if let viewController = self.currentViewController as? SearchListController {
            viewController.delegate = self
            viewController.managedObjectContext = managedObjectContext
        }
        self.addChildViewController(self.currentViewController!)
        self.addSubview(subView: self.currentViewController!.view, toView: self.containerView)
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "first"), style: .plain, target: self, action: #selector(filterList(_:)))
    }
    
    func requestData() {
        if !isRequestingData {
            let location = self.location.replacingOccurrences(of: " ", with: "%20")
            let parameters: Parameters = [
                "location": location,
                "section": self.section
            ]
            
            isRequestingData = true
            print("Making request with section: \(self.section)")
            
            Alamofire.request(serverRequestEventsDataURL, method: .post, parameters: parameters).validate().responseJSON(completionHandler: { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    self.isRequestingData = false
                case .success:
                    if let dict = response.result.value as? [String: AnyObject] {
                        if let section = dict["section"] as? String, let events = dict["events"] as? [[String: Any]] {
                            self.section = section
                            for event in events {
                                print(event)
                                if let newEvent = Event(data: event) {
                                    eventsData.append(newEvent)
                                    print("appended")
                                }
                            }
                        }
                        self.sortEventsBySort()
                        
                        self.isRequestingData = false
                        if let viewController = self.currentViewController as? SearchListController {
                            viewController.updateView()
                            viewController.managedObjectContext = self.managedObjectContext
                        } else if let viewController = self.currentViewController as? SearchMapController {
                            viewController.addAnnotations()
                            viewController.managedObjectContext = self.managedObjectContext
                        }
                    }
                }
            })
        }
    }
    
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        var newViewController: UIViewController?
        if sender.selectedSegmentIndex == 0 {
            newViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchListComponent")
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "first"), style: .plain, target: self, action: #selector(filterList(_:)))
            
        } else {
            newViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchMapComponent")
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "CurrentLocation"), style: .plain, target: self, action: #selector(zoomMap(_:)))
        }
        
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
        if let viewController = self.currentViewController as? SearchListController {
            viewController.updateView()
            viewController.delegate = self
            viewController.managedObjectContext = self.managedObjectContext
        } else if let viewController = self.currentViewController as? SearchMapController {
            viewController.addAnnotations()
            viewController.managedObjectContext = self.managedObjectContext
        }
    }
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParentViewController: nil)
        self.addChildViewController(newViewController)
        self.addSubview(subView: newViewController.view, toView:self.containerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        },
        completion: { finished in
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParentViewController()
            newViewController.didMove(toParentViewController: self)
        })
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
    
    func filterList(_ sender: Any) {
        print("Filter List Opened")
        if let navigationViewController = storyboard?.instantiateViewController(withIdentifier: "barFilterNavigationController") as? UINavigationController, let viewController = navigationViewController.topViewController as? BarFilterController {
            viewController.selectedCategory = selectedCategory
            viewController.selectedSort = selectedSort
            present(navigationViewController, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func cancelToContainerSearchController(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func doneFilterDetails(_ segue: UIStoryboardSegue) {
        print("Recalculate List")
        sortEventsBySort()
    }
    
    func sortEventsBySort() {
        switch selectedSort {
        case .closest:
            eventsData = eventsData.sorted{ $0.distance! < $1.distance! }
            if let viewController = self.currentViewController as? SearchListController {
                viewController.updateView()
                viewController.delegate = self
                viewController.managedObjectContext = self.managedObjectContext
            }
        case .upcoming, .relevance, .popularity:
            return
        }
    }
    
    func zoomMap(_ sender: Any) {
        print("Zoom Map")
        if let searchMapController = self.currentViewController as? SearchMapController {
            searchMapController.zoomMap()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) { // Changes Navigation bar when view leaves to detail view
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchEvents" {
            let barSearchController = segue.destination as! BarSearchController
            barSearchController.managedObjectContext = managedObjectContext
            
            if let viewController = self.currentViewController as? SearchListController {
                barSearchController.currentLocation = viewController.currentLocation
            } else if let viewController = self.currentViewController as? SearchMapController {
                barSearchController.currentLocation = viewController.currentLocation
            }
        }
    }
    
}
