//
//  Mitre+CoreDataClass.swift
//  PersistentExampleService
//
//  Created by Stanly Shiyanovskiy on 22.07.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation
import CoreData

@objc(Mitre)
public class Mitre: NSManagedObject {
    
    internal static func isInDBBy(ID: Int) -> Bool {
        let context = CoreDataStack.instance.persistentContainer.viewContext
        let request: NSFetchRequest<Mitre> = Mitre.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", ID)
        
        do {
            let mitres = try context.fetch(request)
            //for mitre in mitres {
                //print(mitre.title ?? "no name")
            //}
            return !(mitres.isEmpty)
        } catch {
            fatalError("Cannot get trip info")
        }
    }
    
    internal static func getMitres() -> [Mitre] {
        let context = CoreDataStack.instance.persistentContainer.viewContext
        let request: NSFetchRequest<Mitre> = Mitre.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            return results
            
        } catch {
            fatalError("Cannot get mitres info")
        }
    }
}
