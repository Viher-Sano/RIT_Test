//
//  DetailShopTableViewController.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 16.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit

class DetailShopTableViewController: UITableViewController {
    
    var book:Book? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = book?.nameBookCD
        
        self.tableView.estimatedRowHeight = 40.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if book?.descriptionBookCD == nil {
            return 1
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if book?.authorBookCD != nil {
                return 2
            }
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Description"
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).row == 0 && indexPath.section == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
            
            guard let image = UIImage(data: book?.imageBookCD as! Data) else {
                return cell
            }
                cell.imageBook.image = image
            
            
            return cell
            
        } else if (indexPath as NSIndexPath).row == 1 && indexPath.section == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "authorsCell", for: indexPath) as! AuthorsTableViewCell
            
            cell.authorsBookLabel.text = book?.authorBookCD
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! DescriptionTableViewCell
        
        cell.descriptionBookLabel.text = book?.descriptionBookCD
        
        return cell
    }
    
}

