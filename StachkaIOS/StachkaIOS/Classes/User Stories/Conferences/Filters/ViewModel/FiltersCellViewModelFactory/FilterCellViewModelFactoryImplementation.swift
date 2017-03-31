//
//  FilterCellViewModelFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 31.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class FilterCellViewModelFactoryImplementation: FilterCellViewModelFactory {
    func viewModels(from filters: [Filter]) -> [FilterCellViewModel] {
        let sectionFilters = filters as! [SectionFilter]
        let sectionModels = sectionFilters.map {
            SectionFilterCellViewModel(sectionName: $0.title,
                                       associatedFilter: $0,
                                       selected: $0.selected)
        }
        return sectionModels
    }
}
