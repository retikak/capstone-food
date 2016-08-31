//
//  RecipeDetailViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/25/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ingredients: [String] = []
    
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeRatingLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    
    @IBOutlet weak var IngredientsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.IngredientsTableView.reloadData()
        
    }
    
    func updateWithRecipe(recipe: Recipe) {
        title = recipe.recipeName
        self.recipeNameLabel.text = " Recipe Name: \(recipe.recipeName)"
        self.recipeRatingLabel.text = " Recipe rating is \(recipe.rating) / 5 "
        let seconds = recipe.totalTimeInSeconds
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds)
        if  h != 0 || s != 0 {
            self.cookingTimeLabel.text = "Cook time is \(h) hours, \(m) minutes, \(s) seconds"
        }else {
            self.cookingTimeLabel.text = "Cook time is \(m) minutes"
        }
        self.ingredients = recipe.ingredients
        
        
        let mainImage = recipe.mainImages
        if let url = NSURL(string: mainImage) {
            
            ImageController.fetchImageAtURL(url) { (mainImage) in
                if let image = mainImage {
                    self.recipeImage.image = image
                    
                    self.recipeImage.layer.cornerRadius = 5.0
                    self.recipeImage.clipsToBounds = true
                }
            }
        }
        
        
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath)
        if(indexPath.row % 2) != 0 {
            
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        
        cell.textLabel?.text = ingredients[indexPath.row]
        
        cell.detailTextLabel?.text = "+"
        
        return cell
        
        
        
    }
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        height.constant = IngredientsTableView.contentSize.height
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGroceryList" {
            if let groceryListTableVC = segue.destinationViewController as? GroceryListTableViewController {
                let indexPath = self.IngredientsTableView.indexPathForSelectedRow
                guard let selectedRow = indexPath?.row  else { return }
                let recipeIngredient = ingredients[selectedRow]
                groceryListTableVC.items.append(recipeIngredient)
            }
            
        }
    }
}

