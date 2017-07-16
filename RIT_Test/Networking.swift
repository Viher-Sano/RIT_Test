//
//  Networking.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 14.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit
import Foundation

class Networking: NSObject {
    
    static let shared = Networking()
    
    func GET(_ path: String, completion: @escaping (_ success: Bool, _ response: Dictionary<String, AnyObject>?) -> ()) {
        
        let url = URL(string: path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        if url != nil {
            
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "GET"
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
                if error != nil {
                    print(error?.localizedDescription)
                    completion(false, nil)
                } else {
                    if let content = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(json)
                            let res = json as! Dictionary<String, AnyObject>
                            completion(true, res)
                        } catch {
                            completion(false, nil)
                        }
                    }
                }
                
            }
            task.resume()
        }
    }
    
}
