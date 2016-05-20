//
//  KL_Test+CoreDataProperties.swift
//  Test
//
//  Created by bcmac3 on 16/5/6.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension KL_Test {

    @NSManaged var name: String?
    @NSManaged var age: NSNumber?

}
