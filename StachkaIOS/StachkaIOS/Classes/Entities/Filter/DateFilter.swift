//
//  DateFilter.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 09.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class DateFilter: AutoObject, Filter {
    dynamic var title: String = ""

    dynamic var date: NSDate = NSDate()
    dynamic var selected: Bool = false
}
