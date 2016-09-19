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
    var searchResultsTableVC = SearchResultsTableViewController()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.backgroundColor = UIColor(red: 243/255.0, green: 236/255.0, blue: 226/255.0, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.backgroundColor = UIColor(red: 255/255.0, green: 127/255.0, blue: 80/255.0, alpha: 1)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70.0
    
        setUpSearchController()
        addActivityIndicator()
        
        RecipeController.sharedController.getAllRecipes { (recipes) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            })
        }
    }
    
    func addActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.color = UIColor.darkGrayColor()
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//        UIView.animateWithDuration(0.25, animations: {
//            cell.layer.transform = CATransform3DMakeScale(1,1,1)
//        })
        if indexPath.row + 5 == RecipeController.sharedController.recipes.count {
            RecipeController.sharedController.getAllRecipes({ (recipes) in
                print("paging complete.")
                self.tableView.reloadData()
            })
        }
    }
    
    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("resultsController") as? SearchResultsTableViewController
        resultsController?.delegate = self
        searchController = UISearchController(searchResultsController: resultsController)
        guard let searchController = searchController else {return}
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search by recipe name or ingredient"
      // searchController.searchBar =  UISearchBar(CGRectMake(0, 0, self.Bounds.Width, ))

        searchController.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
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
        print("and the count is:")
        print(RecipeController.sharedController.recipes.count)
        return RecipeController.sharedController.recipes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as? CustomRecipeTableViewCell      {
            let recipe = RecipeController.sharedController.recipes[indexPath.row]
            cell.updateCellWithRecipe(recipe)
            cell.layoutSubviews1(RecipeController.sharedController.recipes[indexPath.row])
            cell.backgroundColor = UIColor(red: 243/255.0, green: 236/255.0, blue: 226/255.0, alpha: 1)

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
        } else if segue.identifier == "toRecipeDetailFromSearch" {
            let detailVC = segue.destinationViewController as? RecipeDetailViewController
            let recipe = sender as? Recipe
            detailVC?.recipe = recipe
        }
    }
}

extension RecipeListTableViewController: SelectedCellProtocol {
    func didSelectedRecipe(recipe: Recipe) {
        performSegueWithIdentifier("toRecipeDetailFromSearch", sender: recipe)
    }
}
