//
//  CategoryFilter.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 09.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryFilter: AutoObject, Filter {
    dynamic var title: String = ""
    dynamic var selected: Bool = false
    let sectionFilters = List<SectionFilter>()
}

extension CategoryFilter: ParentFilter {
    var childFilters: [Filter] {
        return sectionFilters.toArray()
    }
}
