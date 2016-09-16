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
        
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeCourseLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var IngredientsTableView: UITableView!
    
    var groceryListVC = GroceryListTableViewController()
    var recipe: Recipe?
    
    
    
    
    
    func didSelectCell(recipe: Recipe) {
        print(recipe.recipeName)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = recipe {
            updateWithRecipe(recipe)
            updatewithImage(recipe)
            
        }
        
        recipeImage.layer.borderColor = UIColor.lightGrayColor().CGColor
        recipeImage.layer.borderWidth = 0.5
        recipeImage.layer.cornerRadius = 5
        recipeImage.layer.masksToBounds = true
        
        directionsButton.layer.borderWidth = 0.5
        directionsButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        directionsButton.layer.cornerRadius = 5
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
        directionsButton.alpha = 1.0
        
        
        
        
    
    }
    
    func updateWithRecipe(recipe: Recipe) {
        RecipeController.sharedController.getNutritionInfo(recipe) { (calorie) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("Kcal is \(calorie)")
                if calorie == 0 {
                    self.recipeCaloriesLabel.text = " "
                } else {
                    self.recipeCaloriesLabel.text = "Calories: \(calorie) Kcal"
                }
            })
        }
        
        
        

        
            
        
        
        
        title = recipe.recipeName
        self.recipeCourseLabel.text = "Course: \(recipe.course[0] ?? "")"
        self.recipeNameLabel.text = recipe.recipeName
        
        let seconds = recipe.totalTimeInSeconds
        let (h,m,_) = secondsToHoursMinutesSeconds(seconds)
        if  h != 0 && m != 0{
            self.cookingTimeLabel.text = "Cook time: \(h) hour, \(m) minutes"
        }else if m != 0 {
            self.cookingTimeLabel.text = "Cook time: \(m) minutes"
        } else {
            self.cookingTimeLabel.text = "Cook time: \(h) hour"
        }
        
        GroceryController.ingredients = recipe.ingredients
       // let mainImage = recipe.mainImages
        
//        if let url = NSURL(string: mainImage) {
//            
//            ImageController.fetchImageAtURL(url) { (mainImage) in
//                if let image = mainImage {
//                    self.recipeImage.image = image
//                    
//                    self.recipeImage.layer.cornerRadius = 5.0
//                    self.recipeImage.clipsToBounds = true
//                    self.recipeImage.layer.masksToBounds = true
//                    self.recipeImage.contentMode = UIViewContentMode.ScaleAspectFill
//                }
//            }
//        }
//        
   }
    func updatewithImage(recipe: Recipe) {
        RecipeController.sharedController.getLargeImage(recipe) { (largeImage) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("the large image is \(largeImage)")
                if let url = NSURL(string: largeImage) {
                    ImageController.fetchImageAtURL(url, completion: { (image) in
                        
                    
                        if let image = image {
                            self.recipeImage.image = image
                            
                            self.recipeImage.layer.cornerRadius = 5.0
                            self.recipeImage.clipsToBounds = true
                            self.recipeImage.layer.masksToBounds = true
                            self.recipeImage.contentMode = UIViewContentMode.ScaleAspectFill
                        }
                    })
                }
                
            })
            
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
            cell.backgroundColor = UIColor(red: 255/255.0, green: 236/255.0, blue: 226/255.0, alpha: 1)

        }
        
        cell.textLabel?.text =
            
            GroceryController.ingredients[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Ingredients"
        return title
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = CGFloat(18.0)
        return height
    }
    
}

