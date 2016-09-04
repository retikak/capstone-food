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
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.backgroundColor = UIColor.redColor()
        let imageView2 = UIImageView(frame: CGRect(x: 49, y: 0, width: 44, height: 44))
        imageView2.backgroundColor = UIColor.blueColor()
        let imageView3 = UIImageView(frame: CGRect(x: 98, y: 0, width: 44, height: 44))
        imageView3.backgroundColor = UIColor.greenColor()
        let imageView4 = UIImageView(frame: CGRect(x: 147, y: 0, width: 44, height: 44))
        imageView4.backgroundColor = UIColor.blackColor()
        let imageView5 = UIImageView(frame: CGRect(x: 196, y: 0, width: 44, height: 44))
        imageView5.backgroundColor = UIColor.yellowColor()
        ratingStarView.addSubview(imageView)
        ratingStarView.addSubview(imageView2)
        ratingStarView.addSubview(imageView3)
        ratingStarView.addSubview(imageView4)
        ratingStarView.addSubview(imageView5)

        
        

        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func layoutSubviews() {
        
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



