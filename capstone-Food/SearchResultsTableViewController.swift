//
//  SearchResultsTableViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 9/9/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    var dataSource: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
    }
    
    
    
    // MARK: - Table view data source
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("resultsCell", forIndexPath: indexPath) as? CustomRecipeTableViewCell {
            let recipe = dataSource[indexPath.row]
            cell.recipeNameLabel.text = recipe.recipeName
            
            
            return cell
        } else {
            return CustomRecipeTableViewCell()
        }
    }
    
    
}
