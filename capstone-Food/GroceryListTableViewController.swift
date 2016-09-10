//
//  GroceryListTableViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/30/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class GroceryListTableViewController: UITableViewController {
    var recipe: Recipe?
        
    @IBOutlet weak var addItemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NSUserDefaults.standardUserDefaults().objectForKey("items") !=  nil {
            GroceryController.ingredients = NSUserDefaults.standardUserDefaults().objectForKey("items") as! [String]
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func AddToListButtonTapped(sender: UIButton) {
        guard let text = addItemTextField.text else {return}
        GroceryController.ingredients.append(text)
        NSUserDefaults.standardUserDefaults().setObject(GroceryController.ingredients, forKey: "items")
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroceryController.ingredients.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groceryList", forIndexPath: indexPath)
        cell.textLabel?.text = GroceryController.ingredients[indexPath.row]
        addItemTextField.text = " "
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            GroceryController.ingredients.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(GroceryController.ingredients, forKey: "items")
            tableView.reloadData()
        }
    }
    
    
    
}
