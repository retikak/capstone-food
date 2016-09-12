//
//  RecipeListTableViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/25/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class RecipeListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController: UISearchController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70.0
        
        setUpSearchController()
        RecipeController.sharedController.getAllRecipes { (recipes) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("got recipes")
                
                self.tableView.reloadData()
            })
        }
        
    }
    
    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("resultsController")
        searchController = UISearchController(searchResultsController: resultsController)
        guard let searchController = searchController else {return}
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search by ingredient, recipe name or cuisine type"
        searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        
    }
    
    
    //  MARK: - SearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchTerm = searchController.searchBar.text?.lowercaseString else {return}
       guard let resultsController = searchController.searchResultsController as? SearchResultsTableViewController else {return}
        resultsController.filteredRecipes = RecipeController.sharedController.recipes.filter({$0.recipeName.lowercaseString.containsString(searchTerm)})
        resultsController.tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(RecipeController.sharedController.recipes.count)
        return RecipeController.sharedController.recipes.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as? CustomRecipeTableViewCell      {
            let recipe = RecipeController.sharedController.recipes[indexPath.row]
            cell.updateCellWithRecipe(recipe)
            cell.layoutSubviews1(RecipeController.sharedController.recipes[indexPath.row])
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
                    let recipe = RecipeController.sharedController.recipes[selectedRow]
                    detailVC.recipe = recipe
                    
                }
            }
        }
    }
}

