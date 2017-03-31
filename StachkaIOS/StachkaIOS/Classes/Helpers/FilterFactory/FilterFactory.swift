//
//  FilterFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 31.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol FilterFactory: class {
    func createFilters() -> [Filter]
}
