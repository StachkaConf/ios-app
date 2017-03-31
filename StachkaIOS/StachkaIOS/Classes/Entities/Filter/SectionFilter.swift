//
//  SectionFilter.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RealmSwift

class SectionFilter: Object, Filter {
    dynamic var title: String = ""
    dynamic var selected: Bool = false
}
