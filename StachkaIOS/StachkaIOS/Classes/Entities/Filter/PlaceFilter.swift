//
//  PlaceFilter.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 09.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class PlaceFilter: AutoObject, Filter {
    dynamic var title: String = ""
    dynamic var selected: Bool = false

    func query() -> String {
        return "place = " + "'" + title + "'"
    }
}
