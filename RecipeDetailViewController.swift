//
//  RecipeDetailViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/25/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit
import SafariServices

class RecipeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var recipeCuisineLabel: UILabel!
    @IBOutlet weak var recipeCourseLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeRatingLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    
    @IBOutlet weak var IngredientsTableView: UITableView!
    
    var groceryListVC = GroceryListTableViewController()
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let recipe = recipe {
            updateWithRecipe(recipe)
            
            
        }
    }
    
    @IBAction func directionsButtonTapped(sender: AnyObject) {
        guard let recipe = recipe else {return}
        RecipeController.sharedController.getDirections(recipe) { (url) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                guard let url = url else {return}
                let safariController = SFSafariViewController(URL: url)
                self.presentViewController(safariController, animated: true, completion: nil)
            })
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.IngredientsTableView.reloadData()
        
    }
    
    func updateWithRecipe(recipe: Recipe) {
        title = recipe.recipeName
        
        self.recipeCourseLabel.text = recipe.course[0] ?? ""
        if recipe.cuisine != nil {
        self.recipeCuisineLabel.text = recipe.cuisine![0] ?? ""
        } else {
            self.recipeCuisineLabel.text = " "
        }
        self.recipeNameLabel.text = " Recipe Name: \(recipe.recipeName)"
        self.recipeRatingLabel.text = " Recipe rating is \(recipe.rating) / 5 "
        let seconds = recipe.totalTimeInSeconds
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds)
        if  h != 0 || s != 0 {
            self.cookingTimeLabel.text = "Cook time is \(h) hours, \(m) minutes, \(s) seconds"
        }else {
            self.cookingTimeLabel.text = "Cook time is \(m) minutes"
        }
        GroceryController.ingredients = recipe.ingredients
        
        
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
        return GroceryController.ingredients.count
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath)
        if(indexPath.row % 2) != 0 {
            
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        
        cell.textLabel?.text = GroceryController.ingredients[indexPath.row]
        
        cell.detailTextLabel?.text = "+"
        
        return cell
        
        
        
    }
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        height.constant = IngredientsTableView.contentSize.height
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "Save item to Grocery List", message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add item", style: .Default) { (action: UIAlertAction) in
            let indexPath = self.IngredientsTableView.indexPathForSelectedRow
            guard let selectedRow = indexPath?.row  else { return }
            let recipeIngredient = GroceryController.ingredients[selectedRow]
            GroceryController.ingredients.append(recipeIngredient)
            print(GroceryController.ingredients)
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
}

