//
//  FilterCellViewModelFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 31.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol FilterCellViewModelFactory: class {
    func viewModels(from filters: [Filter]) -> [FilterCellViewModel]
    func filters(from viewModels: [FilterCellViewModel]) -> [Filter]
}
