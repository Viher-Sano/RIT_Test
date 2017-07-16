//
//  DetailBookTableViewController.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 16.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit
import CoreData

class DetailBookTableViewController: UITableViewController {

    var book:BookNet? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = book?.nameBook
        
        self.tableView.estimatedRowHeight = 40.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    @IBAction func saveBook(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let book = Book(context: managedContext)
        
        var authors:String = ""
        if self.book?.authorBook != nil {
            for author in (self.book?.authorBook!)! {
                authors += author + "\n"
            }
        }
        book.authorBookCD = authors
        book.nameBookCD = self.book?.nameBook
        book.descriptionBookCD = self.book?.descriptionBook
        if self.book?.imageURL != nil {
            let imageURL = URL(string: (self.book?.imageURL!)!)
            do {
                let imageData = try Data(contentsOf: imageURL!)
                book.imageBookCD = imageData as NSData
            } catch {
                return
            }
        }
        
        do {
            try managedContext.save()
        } catch {
            return
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if book?.descriptionBook == nil {
            return 1
        }
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if book?.authorBook != nil {
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
            
            if book?.imageURL != nil {
                let imageURL = URL(string: (book?.imageURL!)!)
                cell.imageBook.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "Open Book"))
            } else {
                cell.imageBook.image = #imageLiteral(resourceName: "Open Book")
            }
            
            return cell
            
        } else if (indexPath as NSIndexPath).row == 1 && indexPath.section == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "authorsCell", for: indexPath) as! AuthorsTableViewCell
            
            var authors:String = ""
            if book?.authorBook != nil {
                for author in (book?.authorBook!)! {
                    authors += author + "\n"
                }
            }
            cell.authorsBookLabel.text = authors
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! DescriptionTableViewCell

        cell.descriptionBookLabel.text = book?.descriptionBook

        return cell
    }

}
