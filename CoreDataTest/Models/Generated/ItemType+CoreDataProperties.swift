//
//  ItemType+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Fivecode on 15/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
