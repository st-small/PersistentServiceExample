//
//  PersistentService.swift
//  PersistentExampleService
//
//  Created by Stanly Shiyanovskiy on 22.07.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation
import CoreData

let B_URL = "http://zolotoe-shitvo.kr.ua/wp-json/wp/v2/posts?categories=6"//&per_page=100"

class PersistentService {
    
    static func getMitres(callback: @escaping ([Mitre])->()) {
        // let try to get mitres from DB
        let mitres = Mitre.getMitres()
        if !mitres.isEmpty {
            print("There are \(mitres.count) mitres in DB")
            callback(mitres)
            getListOfItems(callback: {(mitres: [Mitre]) -> () in
                callback(mitres)
            })
        } else {
            DispatchQueue.global(qos: .background).async {
                getListOfItems(callback: {(mitres: [Mitre]) -> () in
                    DispatchQueue.main.async() {
                        callback(mitres)
                    }
                })
            }
        }
    }
    
    // MARK: - API Functionality -
    static func getListOfItems(callback:@escaping ([Mitre])->()) {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: B_URL)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            // Получение количества всех записей в данной категории
            if let response = response as? HTTPURLResponse {
                print(response)
                
                if let postsCount = response.allHeaderFields["X-WP-Total"] as? String {
                    print(postsCount)
                }
            }
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String, AnyObject>] {
                        var mitres = [Mitre]()
                        let moc = CoreDataStack.instance.persistentContainer.viewContext
                        //_ = CoreDataStack.instance.deleteAllInstancesOf(entity: "Mitre", context: moc)
                        
                        for value in json {
                            
                            let mitre = Mitre(context: moc)
                            
                            if let id = value["id"] as? Int {
                                print(id)
                                let a = Mitre.isInDBBy(ID: id)
                                a == true ? "TRUE" : "FALSE"
                                mitre.id = Int16(id)
                            }
                            
                            if let titleDict = value["title"] as? Dictionary<String, String> {
                                if let title = titleDict["rendered"] {
                                    print(title)
                                    mitre.title = title
                                }
                            }
                            
                            if let featuredImg = value["better_featured_image"] as? Dictionary<String, AnyObject> {
                                if let imgLink = featuredImg["source_url"] as? String {
                                    print(imgLink)
                                    let data = try? Data(contentsOf: URL(string: imgLink)!)
                                    mitre.img = data! as NSData
                                }
                            }
                            
                            mitres.append(mitre)
                            CoreDataStack.instance.saveContext()
                        }
                        //print(json)
                        callback(mitres)
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
}
