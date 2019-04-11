//
//  Category file.swift
//  todoey
//
//  Created by Kavya Joshi on 06/04/19.
//  Copyright © 2019 Kavya Joshi. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object
{

@objc dynamic var name : String = ""
    var Items = List<Item>()

}
