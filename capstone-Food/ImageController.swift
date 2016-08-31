//
//  ImageController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/25/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static func fetchImageAtURL(url: NSURL, completion:(image: UIImage?) ->Void) {
    
        NetworkController.performRequestForURL(url, httpMethod:.Get) { (data, error) in
            guard let data = data else {
                print("Could not fetch data for image")
                completion(image: nil)
                return
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(image: UIImage(data: data))
            })

        }
        
    }
    
    
}
