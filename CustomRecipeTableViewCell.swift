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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}



