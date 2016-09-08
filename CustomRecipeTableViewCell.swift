//
//  CustomRecipeTableViewCell.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/28/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class CustomRecipeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var ratingStarView: UIView!
    
    var spacing :Int = 5
    var stars: Int = 5
    
    
    
    
    
    let filledStarImage = UIImage(named: "filledStar")
    let emptyStarImage = UIImage(named: "emptyStar")
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
        
    }
    
    //    override func setSelected(selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //    }
    
    func layoutSubviews1(recipe:Recipe) {
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        
        let imageView2 = UIImageView(frame: CGRect(x: 49, y: 0, width: 44, height: 44))
        
        
        let imageView3 = UIImageView(frame: CGRect(x: 98, y: 0, width: 44, height: 44))
        
        let imageView4 = UIImageView(frame: CGRect(x: 147, y: 0, width: 44, height: 44))
        
        let imageView5 = UIImageView(frame: CGRect(x: 196, y: 0, width: 44, height: 44))
        
        ratingStarView.addSubview(imageView1)
        ratingStarView.addSubview(imageView2)
        ratingStarView.addSubview(imageView3)
        ratingStarView.addSubview(imageView4)
        ratingStarView.addSubview(imageView5)
        if recipe.rating == 5 {
            imageView1.image = filledStarImage
            imageView2.image = filledStarImage
            imageView3.image = filledStarImage
            imageView4.image = filledStarImage
            imageView5.image = filledStarImage
        }else if recipe.rating == 4 {
            imageView1.image = filledStarImage
            imageView2.image = filledStarImage
            imageView3.image = filledStarImage
            imageView4.image = filledStarImage
            imageView5.image = emptyStarImage
            
        } else if recipe.rating == 3 {
            imageView1.image = filledStarImage
            imageView2.image = filledStarImage
            imageView3.image = filledStarImage
            imageView4.image = emptyStarImage
            imageView5.image = emptyStarImage
        } else if recipe.rating == 2 {
            imageView1.image = filledStarImage
            imageView2.image = filledStarImage
            imageView3.image = emptyStarImage
            imageView4.image = emptyStarImage
            imageView5.image = emptyStarImage
        } else {
            
            imageView1.image = filledStarImage
            imageView2.image = emptyStarImage
            imageView3.image = emptyStarImage
            imageView4.image = emptyStarImage
            imageView5.image = emptyStarImage
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    func getStarImage(starNumber: Int,recipeRating :Int) -> UIImage {
        
        
        if recipeRating >= starNumber {
            return filledStarImage!
        } else {
            return emptyStarImage!
        }
    }
    
    
    
    //    if let recipeRating = Int((RecipeController.sharedController.recipe?.rating)!) {
    //        CustomRecipeTableViewCell.
    //    }
    
    
    
    
    
}



