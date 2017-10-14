//
//  ContainerSearchController.swift
//  VolunteerNow
//
//  Created by Macbook on 10/14/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit

class ContainerSearchController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchListComponent")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(subView: self.currentViewController!.view, toView: self.containerView)
        super.viewDidLoad()
    }
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        var newViewController: UIViewController?
        if sender.selectedSegmentIndex == 0 {
            newViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchListComponent")
        } else {
            newViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchMapComponent")
        }
        
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
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
}
