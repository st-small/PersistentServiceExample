//
//  PersistentService.swift
//  PersistentExampleService
//
//  Created by Stanly Shiyanovskiy on 22.07.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation
import CoreData

let B_URL = "http://zolotoe-shitvo.kr.ua/wp-json/wp/v2/posts?categories=6"

class PersistentService {
    
    // MARK: - API Functionality -
    static func getListOfItems() {
        let array = [Mitre]()
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: B_URL)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String, AnyObject>] {
                        
                        for value in json {
                            
                            if let id = value["id"] as? Int {
                                print(id)
                            }
                            
                            if let titleDict = value["title"] as? Dictionary<String, String> {
                                if let title = titleDict["rendered"] {
                                    print(title)
                                }
                            }
                            
                            if let featuredImg = value["better_featured_image"] as? Dictionary<String, AnyObject> {
                                if let imgLink = featuredImg["source_url"] as? String {
                                    print(imgLink)
                                    let data = try? Data(contentsOf: URL(string: imgLink)!)
                                }
                            }
                            
                            
                            
                            
                        }
                        print(json)
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    // MARK: - CoreData Functionality -
}
