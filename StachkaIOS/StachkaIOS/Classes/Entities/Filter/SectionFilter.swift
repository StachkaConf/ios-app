//
//  SectionFilter.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RealmSwift

class AutoObject: Object {
    dynamic var compoundKey: String = UUID().uuidString

    override class func primaryKey() -> String? {
        return "compoundKey"
    }
}

class SectionFilter: AutoObject, Filter {
    dynamic var title: String = ""
    dynamic var selected: Bool = false
}
