//
//  StoresMapViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 9/7/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class StoresMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
   // @IBOutlet weak var GroceryListTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManger = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error")
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        locationManger.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Your location"
        mapView.addAnnotation(annotation)
        
    }
    
    
    
    
}






