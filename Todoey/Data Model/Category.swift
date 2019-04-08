//
//  Category.swift
//  Todoey
//
//  Created by Salvatore La spina on 08/04/2019.
//  Copyright © 2019 Salvatore La spina. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
     @objc dynamic var name : String = ""
     let items = List<Item>()
}

