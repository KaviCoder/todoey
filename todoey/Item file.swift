//
//  Item file.swift
//  todoey
//
//  Created by Kavya Joshi on 06/04/19.
//  Copyright © 2019 Kavya Joshi. All rights reserved.
//

import Foundation
 import RealmSwift

class Item : Object
{
    @objc dynamic var task : String = ""
    @objc dynamic var done : Bool = false
     var parentCategory = LinkingObjects(fromType: Category.self, property: "Items")
    @objc dynamic var dateCreated : Date?
}
