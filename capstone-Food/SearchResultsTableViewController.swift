//
//  SearchResultsTableViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 9/9/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    var filteredRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredRecipes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultsCell", forIndexPath: indexPath) as? CustomRecipeTableViewCell
        let recipe = filteredRecipes[indexPath.item]
        cell?.updateCellWithRecipe(recipe)
        resignFirstResponder()
        
        return cell ?? CustomRecipeTableViewCell()
        
    }
    
    
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailVC" {
            if let detailVC = segue.destinationViewController as? RecipeDetailViewController {
                let indexPath = self.tableView.indexPathForSelectedRow
                if let selectedRow = indexPath?.row {
                    let recipe = filteredRecipes[selectedRow]
                    detailVC.recipe = recipe
                }
            }
        }
    }
    
    
    
    
    
}
