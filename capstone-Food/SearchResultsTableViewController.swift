//
//  SearchResultsTableViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 9/9/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit


class SearchResultsTableViewController: UITableViewController {
    weak var delegate: SelectedCellProtocol?
    
    var filteredRecipes: [Recipe] = []
    
        override func viewDidLoad() {
        super.viewDidLoad()
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 70.0
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRecipes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath) as? CustomRecipeTableViewCell
        
        let recipe = filteredRecipes[indexPath.item]
        cell?.updateCellWithRecipe(recipe)
        cell?.layoutSubviews1(RecipeController.sharedController.recipes[indexPath.row])

        resignFirstResponder()
        
        return cell ?? CustomRecipeTableViewCell()
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let recipe = filteredRecipes[indexPath.row]
        delegate?.didSelectedRecipe(recipe)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}



