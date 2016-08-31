//
//  Recipe.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/25/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import Foundation

struct Recipe {
    
    private let kId = "id"
    private let kRecipeName = "recipeName"
    private let kRating = "rating"
    private let kTotalTimeInSeconds = "totalTimeInSeconds"
    private let kSourceDisplayName = "sourceDisplayName"
    private let kIngredients = "ingredients"
    private let ksmallImageUrls = "smallImageUrls"
    private let kimageUrlsBySize = "imageUrlsBySize"

    
    var Id : String = ""
    var recipeName: String = ""
    var rating: Int = 0
    var totalTimeInSeconds: Int = 0
    var sourceDisplayName: String = ""
    var ingredients : [String] = []
    var images: [String] = []
    var mainImages: String = ""
    
    
    
    init?(jsonDictionary: [String: AnyObject]) {
        
        guard let ID = jsonDictionary[kId] as? String else {return nil}
        
        guard let imagesSizesDictionary = jsonDictionary[kimageUrlsBySize] as? [String: AnyObject],
            let image = imagesSizesDictionary["90"] as? String else { return nil }
        
        self.Id = ID
        self.recipeName = jsonDictionary[kRecipeName] as? String ?? ""
        self.rating = jsonDictionary[kRating] as? Int ?? 0
        self.totalTimeInSeconds = jsonDictionary[kTotalTimeInSeconds] as? Int ?? 0
        self.sourceDisplayName = jsonDictionary[kSourceDisplayName] as? String ?? ""
        self.ingredients = jsonDictionary[kIngredients] as? [String] ?? []
        self.images = jsonDictionary[ksmallImageUrls] as? [String] ?? []
        self.mainImages = image
     
    
    }
    
    
    
}