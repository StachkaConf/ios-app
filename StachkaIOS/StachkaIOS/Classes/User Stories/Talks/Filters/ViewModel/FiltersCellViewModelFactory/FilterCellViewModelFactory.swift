//
//  FilterCellViewModelFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 31.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol FilterCellViewModelFactory: class {
    func navigationViewModels(from filters: [Filter]) -> [FilterCellViewModel]
    func tickViewModels(fromParentFilter parentFilter: ParentFilter, filters: [Filter]) -> [FilterCellViewModel]
    func tickViewModels(from filters: [Filter]) -> [FilterCellViewModel]
    func filtersWithChangesReflected(viewModels: [FilterCellViewModel], parentFilter: ParentFilter) -> [Filter]
}
