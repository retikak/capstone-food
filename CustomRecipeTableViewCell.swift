//
//  CustomRecipeTableViewCell.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/28/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class CustomRecipeTableViewCell: UITableViewCell {
    var recipe: Recipe?
    
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        fetchImageForRecipe()
        
            }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func fetchImageForRecipe() {
        if let recipe = recipe {
            let recipeImage = recipe.imageString
            if let url = NSURL(string: recipeImage) {
                
                ImageController.fetchImageAtURL(url) { (image) in
                    if let image = image {
                        self.recipeImage.image = image
                        self.recipeImage.layer.cornerRadius = 5.0
                        self.recipeImage.clipsToBounds = true
                        
                        
                    }
                }
            }
        }

    }
    
    
    
}
