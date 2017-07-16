//
//  ShopCatTableViewController.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 16.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit
import CoreData

class ShopCatTableViewController: UITableViewController {

    var data: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        
        do {
            data = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [Book]
            tableView.reloadData()
        } catch {
            return
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.count == 0 {
            return 1
        }
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if data.count == 0 {
            return 44
        }
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotFoundCell", for: indexPath)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        
        let book = data[indexPath.row]
        
        cell.configureCellCD(book: book)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if data.count == 0 {
            return
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let bookVC = sb.instantiateViewController(withIdentifier: "bookShopVC") as? DetailShopTableViewController {
            bookVC.book = data[indexPath.row]
            self.navigationController?.pushViewController(bookVC, animated: true)
        }
    }
}
