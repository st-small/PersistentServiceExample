//
//  Mitre+CoreDataProperties.swift
//  PersistentExampleService
//
//  Created by Stanly Shiyanovskiy on 22.07.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation
import CoreData


extension Mitre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mitre> {
        return NSFetchRequest<Mitre>(entityName: "Mitre")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var img: NSData?

}
