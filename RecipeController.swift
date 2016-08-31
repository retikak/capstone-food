//
//  RecipeController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/25/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import Foundation


class RecipeController {
    
    private (set) var recipes: [Recipe] = [] {
        
        didSet {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("got recipe")
                
            })
        }
        
    }
    
    //TODO: test
    init() {
        getAllRecipes { (recipes) in
            
        }
    }

    static let sharedController = RecipeController()
    
    private let baseURLKey = "https://api.yummly.com/v1"
    private let apiKey = "db906b1bb9aa10be45ffb3d4676d45e8"
    private let appIdKey = "edd3f7af"
    private let baseURL = NSURL(string:"https://api.yummly.com/v1/api/recipes")
    
    
    /*
     http://api.yummly.com/v1/api/recipe/recipe-id?_app_id=YOUR_ID&_app_key=YOUR_APP_KEY
     
     http://api.yummly.com/v1/api/recipe/French-Onion-Soup-1838096?_app_id=edd3f7af&_app_key=db906b1bb9aa10be45ffb3d4676d45e8
     
     let cuisineSearchURL = "\(baseURLKey)" + "/api/recipes?_app_id=\(appId)&_app_key=\(apiKey)&allowedCuisine[]=cuisine^cuisine-\(cuisineType.lowercaseString)&maxResult=15&start=0"
     
     https://api.yummly.com/v1/api/recipes?_app_id=edd3f7af&_app_key=db906b1bb9aa10be45ffb3d4676d45e8&allowedCuisine[]=cuisine^cuisine-italian&maxResult=15&start=0
     
     https://api.yummly.com/v1/api/recipes?_app_id=edd3f7af&_app_key=db906b1bb9aa10be45ffb3d4676d45e8&maxResult=10&start=10&requirePictures=true
     
     http://api.yummly.com/v1/api/recipes?_app_id=edd3f7af&_app_key=db906b1bb9aa10be45ffb3d4676d45e8&q=onion+soup&requirePictures=true
     */
    
    
    
    
    func getRecipeWithSearchTerm(searchTerm: String, completion: (recipes: [Recipe]) -> Void) {
        
        let urlParameters = ["_app_id": appIdKey, "_app_key": apiKey, "q" : "\(searchTerm)", "maxResult": "15", "start": "0", "requirePictures": "true",
        "allowedDiet": "390^Pescetarian", "alloweDiet[]": "388^Lacto vegetarian"]
        
        if let url = baseURL {
            NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters, body: nil , completion: { (data, error) in
                if let data = data, let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []), let jsonDictionary = jsonAnyObject as? [String: AnyObject], let matchesArray = jsonDictionary["matches"] as? [[String: AnyObject]] {
                    
                    var recipes: [Recipe] = []
                    
                    for matchDictionary in matchesArray {
                        if let recipe = Recipe(jsonDictionary: matchDictionary) {
                            recipes.append(recipe)
                        }
                        
                    }
                    completion(recipes: recipes)
                    
                    
                } else {
                    completion(recipes: [])
                }
            })
            
        } else {
            print("error fetching url")
            completion(recipes: [])
            
        }
        
        
    }
    
    func getAllRecipes(completion:(recipes: [Recipe]) -> Void) {
        let urlParameters = ["_app_id": appIdKey, "_app_key": apiKey, "maxResult": "15", "start": "0", "requirePictures": "true"]
        
        if let url = baseURL {
            NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters, body: nil , completion: { (data, error) in
                if let data = data,
                    let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                    let jsonDictionary = jsonAnyObject as? [String: AnyObject],
                    let matchesArray = jsonDictionary["matches"] as? [[String: AnyObject]] {
                    
                    var recipes: [Recipe] = []
                    
                    for matchDictionary in matchesArray {
                        
                        if let recipe = Recipe(jsonDictionary: matchDictionary) {
                            recipes.append(recipe)
                        }
                        
                    }
                    completion(recipes: recipes)
                    
                    
                } else {
                    completion(recipes: [])
                }
            })
            
        } else {
            print("error fetching url")
            completion(recipes: [])
            
        }
        
        
    }
    
}

