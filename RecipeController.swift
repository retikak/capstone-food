//
//  RecipeController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/25/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import Foundation

protocol RecipeControllerDelegate: class {
    func recipesChanged()
}


class RecipeController {
    static let sharedController = RecipeController()
    weak var delegate: RecipeControllerDelegate?
    
    
    
    private (set) var recipes: [Recipe] = [] {
        
        didSet {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate?.recipesChanged()
            })
        }
        
    }
    init() {
        getAllRecipes { (recipes) in
            //print(recipes)
        }
        
        
    }
    
    
    private let baseURLKey = "https://api.yummly.com/v1"
    private let apiKey = "db906b1bb9aa10be45ffb3d4676d45e8"
    private let appIdKey = "edd3f7af"
    private let baseURL = NSURL(string:"https://api.yummly.com/v1/api/recipes")
    private let baseURLForDirections = NSURL(string: "http://api.yummly.com/v1/api/recipe/recipe-id?")
    
    
    /*
     
     "http://api.yummly.com/v1/api/recipe/French-Onion-Soup-The-Pioneer-Woman-Cooks-_-Ree-Drummond-41364?_app_id=edd3f7af&_app_key=db906b1bb9aa10be45ffb3d4676d45e8
     http://api.yummly.com/v1/api/recipe/recipe-id?_app_id=YOUR_ID&_app_key=YOUR_APP_KEY
     
     http://api.yummly.com/v1/api/recipe/French-Onion-Soup-1838096?_app_id=edd3f7af&_app_key=db906b1bb9aa10be45ffb3d4676d45e8
     
     let cuisineSearchURL = "\(baseURLKey)" + "/api/recipes?_app_id=\(appId)&_app_key=\(apiKey)&allowedCuisine[]=cuisine^cuisine-\(cuisineType.lowercaseString)&maxResult=15&start=0"
     
     https://api.yummly.com/v1/api/recipes?_app_id=edd3f7af&_app_key=db906b1bb9aa10be45ffb3d4676d45e8&allowedCuisine[]=cuisine^cuisine-italian&maxResult=15&start=0
     
     https://api.yummly.com/v1/api/recipes?_app_id=edd3f7af&_app_key=db906b1bb9aa10be45ffb3d4676d45e8&maxResult=10&start=10&requirePictures=true
     
     http://api.yummly.com/v1/api/recipes?_app_id=edd3f7af&_app_key=db906b1bb9aa10be45ffb3d4676d45e8&q=onion+soup&requirePictures=true
     */
    
    
    func getDirections(recipe: Recipe, completion: (url: NSURL?) ->Void) {
        let id = recipe.Id
        let completeidString = "http://api.yummly.com/v1/api/recipe" + "/\(id)?"
        let baseURLForDirections = NSURL(string: completeidString)
        let urlParameters = ["_app_id": appIdKey, "_app_key": apiKey]
        
        if let url = baseURLForDirections {
            NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters, body: nil, completion: { (data, error) in
                if let data = data,
                    let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                    let jsonDictionary = jsonAnyObject as? [String: AnyObject],
                    let source = jsonDictionary["source"] as? [String: AnyObject],
                    let sourceURL = source["sourceRecipeUrl"] as? String, url = NSURL(string: sourceURL) {
                    completion(url: url)
                    
                } else {
                    completion(url: nil)
                }
                
            })
        }
        
        
    }
    
    func getNutritionInfo(recipe: Recipe, completion: (calorie: Int) ->Void) {
        let id = recipe.Id
        let completeidString = "http://api.yummly.com/v1/api/recipe" + "/\(id)?"
        let baseURLForDirections = NSURL(string: completeidString)
        let urlParameters = ["_app_id": appIdKey, "_app_key": apiKey]
        
        if let url = baseURLForDirections {
            NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters, body: nil, completion: { (data, error) in
                if let data = data,
                    let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                    let jsonDictionary = jsonAnyObject as? [String: AnyObject],
                    let nutritionArrayOfDictionary = jsonDictionary["nutritionEstimates"] as? [[String: AnyObject]],
                    nutritionDict = nutritionArrayOfDictionary.first?["value"] as? Int {
                    
                    completion(calorie: nutritionDict)
                    //print(nutritionDict)
                }else {
                    completion(calorie: 0)
                }
            })
        }
    }
    
    
    func getRecipesWithSearchTerm(searchTerm: String, completion: (success: Bool, recipes: [Recipe]) -> Void) {
        
        let urlParameters = ["_app_id": appIdKey, "_app_key": apiKey, "q" : "\(searchTerm)", "maxResult": "35", "start": "0"]
        if let url = baseURL {
            NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters, body: nil, completion: { (data, error) in
                guard let data = data , let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []), let jsonDictionary = jsonAnyObject as? [String: AnyObject], let matchesArray = jsonDictionary["matches"] as? [[String: AnyObject]] else {completion(success: false, recipes: [])
                    return
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let recipes = matchesArray.flatMap{Recipe(jsonDictionary: $0)}
                    
                    completion(success: true, recipes: recipes)
                })
                
            })
        }
    }
    
    
    
    
    
    func getAllRecipes(completion:(recipes: [Recipe]) -> Void) {
        let urlParameters = ["_app_id": appIdKey, "_app_key": apiKey, "maxResult": "35", "start": "0",  /*"requirePictures": "true"*/]
        
        if let url = baseURL {
            NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters, body: nil , completion: { (data, error) in
                if let data = data,
                    let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                    let jsonDictionary = jsonAnyObject as? [String: AnyObject],
                    let matchesArray = jsonDictionary["matches"] as? [[String: AnyObject]] {
                    
                    //                    var recipes: [Recipe] = []
                    
                    for matchDictionary in matchesArray {
                        
                        if let recipe = Recipe(jsonDictionary: matchDictionary) {
                            self.recipes.append(recipe)
                        }
                        
                        
                    }
                    completion(recipes: self.recipes)
                    
                    
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

