//
//  SearchResultsTableViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 9/9/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit


class SearchResultsTableViewController: UITableViewController {
    //var delegate: SelectedCellProtocol?
    
    
    var filteredRecipes: [Recipe] = []
    
    //    func didSelectCell(recipe: Recipe) {
    //        print(recipe)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        //delegate = self
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredRecipes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath) as? ResultTableViewCell
        let recipe = filteredRecipes[indexPath.item]
//        cell?.textLabel?.text = recipe.recipeName
        cell?.updateCellWithRecipe(recipe)
        return cell ?? CustomRecipeTableViewCell()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let recipe = filteredRecipes[indexPath.row]
        self.presentingViewController?.performSegueWithIdentifier("toRecipeDetailFromSearch", sender: recipe as? AnyObject)
        let detailVC = RecipeDetailViewController()
        detailVC.recipe = recipe
        
    }
    
    
    
    //        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //                    //self.delegate?.didSelectCell(cell.textLabel.text) as? CustomRecipeTableViewCell
    //                   let recipe = RecipeController.sharedController.recipes[indexPath.row]
    //                    self.presentingViewController?.performSegueWithIdentifier("toRecipeDetail", sender: recipe as? AnyObject)
    //                     let detailVC = RecipeDetailViewController()
    //
    //
    //
    //                    detailVC.recipe = recipe
    //
    //                }
    //
    
    
    
}



