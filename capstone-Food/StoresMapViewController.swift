//
//  StoresMapViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 9/7/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit
import MapKit

class StoresMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayGroceryStores()
    }
    
    func displayGroceryStores() {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Groceries"
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler { (localSearchResponse, error) in

            if error != nil {
                print("error occured in search: \(error?.localizedDescription)")
                
            } else if localSearchResponse!.mapItems.count == 0 {
                print("No Matches found")
            } else {
                print("matches found")
                
                for item in localSearchResponse!.mapItems {
                    print(item.name)
                }
            }
        }
    
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
