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
   // @IBOutlet weak var recipeCuisineLabel: UILabel!
    @IBOutlet weak var recipeCourseLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var IngredientsTableView: UITableView!
    
    var groceryListVC = GroceryListTableViewController()
    var recipe: Recipe?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let recipe = recipe {
            updateWithRecipe(recipe)
        }
        let size: CGFloat = 35.0
        recipeCaloriesLabel.textAlignment = .Center
        recipeCaloriesLabel.bounds = CGRectMake(0.0, 0.0, size, size)
        recipeCaloriesLabel.layer.cornerRadius = size/2
        recipeCaloriesLabel.layer.borderWidth = 1
        recipeCaloriesLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
        recipeCaloriesLabel.center = CGPointMake(200.0, 200.0)
        self.view.addSubview(recipeCaloriesLabel)
        
        recipeCourseLabel.textAlignment = .Center
        recipeCourseLabel.bounds = CGRectMake(0.0, 0.0, size, size)
        recipeCourseLabel.layer.cornerRadius = size/2
        recipeCourseLabel.layer.borderWidth = 1
        recipeCourseLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
        recipeCourseLabel.center = CGPointMake(200.0, 200.0)
        self.view.addSubview(recipeCourseLabel)

        
        directionsButton.layer.borderWidth = 1
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
        
    }
    
    func updateWithRecipe(recipe: Recipe) {
        RecipeController.sharedController.getNutritionInfo(recipe) { (calorie) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("Kcal is \(calorie)")
                if calorie == 0 {
                    self.recipeCaloriesLabel.text = " "
                } else {
                    self.recipeCaloriesLabel.text = "\(calorie) Kcal"
                    
                }
            })
        }
        
        
        title = recipe.recipeName
        
        self.recipeCourseLabel.text = recipe.course[0] ?? ""
//        if recipe.cuisine != nil {
//            self.recipeCuisineLabel.text = recipe.cuisine![0] ?? ""
//        } else {
//            self.recipeCuisineLabel.text = " "
//        }
        self.recipeNameLabel.text = recipe.recipeName
        
        let seconds = recipe.totalTimeInSeconds
        let (h,m,_) = secondsToHoursMinutesSeconds(seconds)
        if  h != 0 && m != 0{
            self.cookingTimeLabel.text = "Cook time is \(h) hour, \(m) minutes"
        }else if m != 0 {
            self.cookingTimeLabel.text = "Cook time is \(m) minutes"
        } else {
            self.cookingTimeLabel.text = "Cook time is \(h) hour"
        }
        
        
        
        
        
//        let (h,m,s) = secondsToHoursMinutesSeconds(seconds)
//        if  h != 0 || s != 0 {
//            self.cookingTimeLabel.text = "Cook time is \(h) hours, \(m) minutes, \(s) seconds"
//        }else {
//            self.cookingTimeLabel.text = "Cook time is \(m) minutes"
//        }
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
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        cell.textLabel?.text =
            
            GroceryController.ingredients[indexPath.row]
        
        
        
        return cell
        
        
    }
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        height.constant = IngredientsTableView.contentSize.height
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Ingredients"
        return title
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = CGFloat(20.0)
        return height
    }
    
    
    
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let alert = UIAlertController(title: "Save item to Grocery List", message: nil, preferredStyle: .Alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        let addAction = UIAlertAction(title: "Add item", style: .Default) { (action: UIAlertAction) in
//            let indexPath = self.IngredientsTableView.indexPathForSelectedRow
//            guard let selectedRow = indexPath?.row  else { return }
//            let recipeIngredient = GroceryController.ingredients[selectedRow]
//            GroceryController.ingredients.append(recipeIngredient)
//            
//        }
//        
//        alert.addAction(cancelAction)
//        alert.addAction(addAction)
//        
//        
//        self.presentViewController(alert, animated: true, completion: nil)
//        
//    }
    
    
}

