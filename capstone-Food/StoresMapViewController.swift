//
//  StoresMapViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 9/7/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit
import CoreLocation

class StoresMapViewController: UIViewController {
    
    @IBOutlet weak var StoreListTableView: UITableView!
    
//    @IBOutlet weak var mapView: MKMapView!
    
    var locationManger: CLLocationManager?
    var startLocation: CLLocation?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger = CLLocationManager()
        locationManger?.delegate = self
        locationManger?.desiredAccuracy = kCLLocationAccuracyBest
        locationManger?.requestAlwaysAuthorization()
        
        
        
        
        
    }
    
    
    
}

extension StoresMapViewController: CLLocationManagerDelegate {
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
            print(startLocation)
        } else {
            guard let latest = locations.first else {return}
            let distanceInMeters = startLocation?.distanceFromLocation(latest)
            print("distance in meters: \(distanceInMeters!)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            locationManger?.requestLocation()
            locationManger?.allowsBackgroundLocationUpdates = true
        }
    }
    
}




