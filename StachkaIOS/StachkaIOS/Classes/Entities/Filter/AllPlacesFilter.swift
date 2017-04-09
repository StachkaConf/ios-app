//
//  AllPlacesFilter.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 09.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RealmSwift

class AllPlacesFilter: AutoObject, Filter {
    dynamic var title: String = ""
    dynamic var selected: Bool = false
    let placeFilters = List<PlaceFilter>()
}

extension AllPlacesFilter: ParentFilter {
    var childFilters: [Filter] {
        return placeFilters.toArray()
    }
}
