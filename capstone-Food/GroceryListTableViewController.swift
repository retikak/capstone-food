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
    var ingredients: [String] = []
    var items = [String]()
    
    @IBOutlet weak var addItemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NSUserDefaults.standardUserDefaults().objectForKey("items") !=  nil {
            items = NSUserDefaults.standardUserDefaults().objectForKey("items") as! [String]
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func AddToListButtonTapped(sender: UIButton) {
        guard let text = addItemTextField.text else {return}
        items.append(text)
        NSUserDefaults.standardUserDefaults().setObject(items, forKey: "items")
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groceryList", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            items.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(items, forKey: "items")
            tableView.reloadData()
        }
    }
    
    
    
}
