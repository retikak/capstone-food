//
//  RecipeListTableViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/25/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class RecipeListTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    var searchResultsRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RecipeController.sharedController.getAllRecipes { (recipes) in
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.searchResultsRecipes = recipes
                self.tableView.reloadData()
            })
        }
        
    }

    
    //  MARK: - SearchBar Delegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text?.lowercaseString else {return}
        RecipeController.sharedController.getRecipeWithSearchTerm(searchTerm) { (recipes) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.searchResultsRecipes = recipes
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - SearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchTerm = searchController.searchBar.text?.lowercaseString else {return}
        let resultsController = searchController.searchResultsController as? SearchResultsTableViewController
        resultsController?.dataSource = RecipeController.sharedController.recipes.filter({$0.recipeName.lowercaseString.containsString(searchTerm)})
        resultsController?.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsRecipes.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as? CustomRecipeTableViewCell      {
            let recipe = searchResultsRecipes[indexPath.row]
            let recipeImage = recipe.mainImages
            // let mainImage = recipe.mainImages
            if let url = NSURL(string: recipeImage) {
                
                ImageController.fetchImageAtURL(url) { (image) in
                    if let image = image {
                        cell.recipeImage.image = image
                        cell.recipeImage.layer.cornerRadius = 5.0
                        cell.recipeImage.clipsToBounds = true
                    }
                }
            }
            
            
            
            cell.sourceNameLabel.text = "source display name : \(recipe.sourceDisplayName)"
            cell.recipeNameLabel.text = recipe.recipeName
            cell.ratingLabel.text = String("rating is \(recipe.rating) out of 5")
            cell.totalTimeLabel.text = String(recipe.totalTimeInSeconds)
            
            return cell
            
        } else {
            
            return CustomRecipeTableViewCell()
        }
    }
    
     // MARK: - Navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toRecipeDetail" {
            if let detailVC = segue.destinationViewController as? RecipeDetailViewController {
               
                let indexPath = self.tableView.indexPathForSelectedRow
                if let selectedRow = indexPath?.row {
                    let recipe = searchResultsRecipes[selectedRow]
                    detailVC.recipe = recipe
                    
                }
            }
        }
    }
}

