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
    var directionsURL = "http://www.yummly.com/recipe/CHOCOLATE-CARAMEL-BARS-1845776"
    
    
    
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeRatingLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!

    @IBOutlet weak var IngredientsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IngredientsTableView.backgroundColor = UIColor.blueColor()
        
        
        
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.IngredientsTableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateWithRecipe(recipe: Recipe) {
        title = recipe.recipeName
        self.recipeNameLabel.text = recipe.recipeName
        self.recipeRatingLabel.text = String(recipe.rating)
        self.cookingTimeLabel.text = String(recipe.totalTimeInSeconds)
        self.ingredients = recipe.ingredients
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
        
            
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


