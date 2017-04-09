//
//  FilterCellViewModelFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 31.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class FilterCellViewModelFactoryImplementation: FilterCellViewModelFactory {
    
    func navigationViewModels(from filters: [Filter]) -> [FilterCellViewModel] {
        let navigationModels = filters.map {
            SectionFilterCellViewModel(associatedCell: NavigationFilterCell.self,
                                       sectionName: $0.title,
                                       selected: $0.selected)
        }
        return navigationModels
    }

    func tickViewModels(from filters: [Filter]) -> [FilterCellViewModel] {
        let sectionModels = filters.map {
            SectionFilterCellViewModel(associatedCell: TickFilterCell.self,
                                       sectionName: $0.title,
                                       selected: $0.selected)
        }
        return sectionModels
    }

    func filtersWithChangesReflected(viewModels: [FilterCellViewModel], parentFilter: ParentFilter) -> [Filter] {
        let allFilters = [parentFilter] + parentFilter.childFilters
        for (offset, element) in viewModels.enumerated() {
            allFilters[offset].selected = element.selected
        }

        return allFilters
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
