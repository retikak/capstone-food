//
//  GroceryListTableViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 8/30/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class GroceryListTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addItemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("items") !=  nil {
            GroceryController.items = NSUserDefaults.standardUserDefaults().objectForKey("items") as! [String]
        }
        self.addItemTextField.delegate = self
        
        addButton.layer.cornerRadius = 5.0
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func AddToListButtonTapped(sender: UIButton) {
        guard self.addItemTextField.text?.characters.count > 0 else {
            let alert = UIAlertController()
            alert.title = "No Text"
            alert.message = "Please enter item to add in the box"
            let cancelAction = UIAlertAction(title: "cancel", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
            
        }
        guard let text = addItemTextField.text else {return}
        GroceryController.items.append(text)
        NSUserDefaults.standardUserDefaults().setObject(GroceryController.items, forKey: "items")
        addItemTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroceryController.items.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groceryList", forIndexPath: indexPath)
        cell.textLabel?.text = GroceryController.items[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            GroceryController.items.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(GroceryController.items, forKey: "items")
            tableView.reloadData()
        }
    }
}
