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
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var ratingStarView: UIView!
    
    var spacing :Int = 5
    var stars: Int = 5
    let filledStarImage = UIImage(named: "filledStar")
    let emptyStarImage = UIImage(named: "emptyStar")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    func layoutSubviews1(recipe:Recipe) {
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        
        let imageView2 = UIImageView(frame: CGRect(x: 18, y: 0, width: 15, height: 15))
        
        
        let imageView3 = UIImageView(frame: CGRect(x: 36, y: 0, width: 15, height: 15))
        
        let imageView4 = UIImageView(frame: CGRect(x: 54, y: 0, width: 15, height: 15))
        
        let imageView5 = UIImageView(frame: CGRect(x: 72, y: 0, width: 15, height: 15))
        imageView1.contentMode = .ScaleToFill
        imageView5.contentMode = .ScaleToFill
        
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
    
    func updateCellWithRecipe(recipe: Recipe) {
        
        //let recipeImage = recipe.mainImages
        
        
        if let url = NSURL(string: recipe.mainImages) {
            
            ImageController.fetchImageAtURL(url) { (image) in
                if let image = image {
                    self.recipeImage.image = image
                    self.recipeImage.layer.cornerRadius = 5.0
                    self.recipeImage.clipsToBounds = true
                }
            }
        }
        
        
        
        sourceNameLabel.text = recipe.sourceDisplayName
        recipeNameLabel.text = recipe.recipeName
        totalTimeLabel.text = String(recipe.totalTimeInSeconds)
        
        let seconds = recipe.totalTimeInSeconds
        let (h,m,_) = secondsToHoursMinutesSeconds(seconds)
        if  h != 0 && m != 0{
            totalTimeLabel.text = "Cook time is \(h) hours, \(m) minutes"
        }else if m != 0 {
            totalTimeLabel.text = "Cook time is \(m) minutes"
        } else {
            totalTimeLabel.text = "Cook time is \(h) hours"
        }
    }



func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}
}












