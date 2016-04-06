//
//  AppDelegate.swift
//  swiftdemo
//
//  Created by luosai19910103@163.com on 15/9/28.
//  Copyright © 2015年 . All rights reserved.
////  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var name: String?
    @NSManaged var phoneNum: NSNumber?
    @NSManaged var age: NSNumber?

}
