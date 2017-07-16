//
//  BookTableViewController.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 14.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    private var _data:[BookNet]?
    var data:[BookNet]? {
        get {
            return _data
        }
        set {
            _data = newValue
            tableView.reloadData()
            //self.viewWillAppear(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - API
    
    func getBooks(_ param: String) {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(param)"
        
        Networking.shared.GET(urlString) { (success, respons) in
            DispatchQueue.main.async {
                guard let data = respons?["items"] as? [AnyObject] else {
                    self.data = nil
                    return
                }
                
                let locData: [BookNet] = data.flatMap({ BookNet(dictionary: $0 as! NSDictionary) })
                self.data = locData
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data?.count == 0 || data == nil {
            return 1
        }
        return (data?.count)!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if data?.count == 0 || data == nil {
            return 44
        }
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data?.count == 0 || data == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotFoundCell", for: indexPath)
            
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        
        let book = data?[indexPath.row]
        
        cell.configureCell(book: book!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if data?.count == 0 || data == nil {
            return
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let bookVC = sb.instantiateViewController(withIdentifier: "bookVC") as? DetailBookTableViewController {
            bookVC.book = data?[indexPath.row]
            self.navigationController?.pushViewController(bookVC, animated: true)
        }
    }
    
}

extension BookTableViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        self.data = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.getBooks(searchBar.text!)
        searchBar.endEditing(true)
    }
    
}
