//
//  Item+CoreDataClass.swift
//  CoreDataTest
//
//  Created by Fivecode on 15/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
    
}
