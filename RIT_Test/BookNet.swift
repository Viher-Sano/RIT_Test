//
//  BookNet.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 16.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit

class BookNet: NSObject {

    let imageURL:String?
    let nameBook:String
    let authorBook:[String]?
    let descriptionBook:String?
    
    init(dictionary: NSDictionary) {
        let volInfo:NSDictionary = dictionary.object(forKey: "volumeInfo") as! NSDictionary//["volumeInfo"] as! NSDictionary
        
        nameBook = volInfo["title"] as! String
        descriptionBook = volInfo["description"] as? String
        authorBook = volInfo["authors"] as? [String]
        
        if let image:[String : AnyObject] = volInfo["imageLinks"] as? [String:AnyObject] {
            imageURL = image["thumbnail"] as? String
        } else {
            imageURL = nil
        }
    }
    
}
