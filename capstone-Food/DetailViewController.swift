//
//  DetailViewController.swift
//  capstone-Food
//
//  Created by Retika Kumar on 9/12/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
   static var recipe: Recipe?
    var sectionArray = ["Name", "Cuisine", "Course", "Calories", "Cooking Time", "ingresients"]
    var rowArray = [[recipe?.recipeName], [recipe?.cuisine?[0] ?? ""], [recipe?.course[0] ?? ""] ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            return 2
            
        
        } else if (section == 3) {
        return GroceryController.ingredients.count
        }
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = "Name"
        } else if indexPath.section == 3 {
            cell.textLabel?.text = "ing"
        }
        
        return cell
        
        
    }
    
    
    
}
