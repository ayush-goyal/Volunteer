//
//  SearchMapController.swift
//  VolunteerNow
//
//  Created by Macbook on 10/14/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SearchMapController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var eventsData = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        
        zoomMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            mapView.showsUserLocation = true
        }
    }
    
    func zoomMap() {
        if let currentLocation: CLLocationCoordinate2D = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegionMakeWithDistance(currentLocation, 5000, 5000)
            mapView.setRegion(viewRegion, animated: true)
        }
    }
    
    func addAnnotations() {
        mapView.addAnnotations(eventsData)
    }

}


extension SearchMapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier = "event"
        var annotationView: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            let infoButton = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = infoButton
            //annotationView.calloutOffset = CGPoint(x: -5, y: 5)
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let event = view.annotation as? Event else { return }
        
        if let eventDetailController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetailController") as? EventDetailController {
            eventDetailController.event = event
            //present(eventDetailController, animated: true, completion: nil)
            navigationController?.pushViewController(eventDetailController, animated: true)
        }
    }
}
