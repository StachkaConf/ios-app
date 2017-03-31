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
                                       selected: $0.selected)
        }
        return sectionModels
    }

    func filters(from viewModels: [FilterCellViewModel]) -> [Filter] {
        return viewModels.flatMap(transform)
    }

    private func transform(_ filterViewModel: FilterCellViewModel) -> Filter? {
        switch filterViewModel {
        case is SectionFilterCellViewModel:
            return transform(filterViewModel as! SectionFilterCellViewModel)
        default:
            return nil
        }
    }

    private func transform(_ filterViewModel: SectionFilterCellViewModel) -> Filter? {
        let sectionFilter = SectionFilter()
        sectionFilter.title = filterViewModel.sectionName
        sectionFilter.selected = filterViewModel.selected

        return sectionFilter
    }
}
