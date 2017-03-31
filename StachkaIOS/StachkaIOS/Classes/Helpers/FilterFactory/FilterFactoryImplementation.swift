//
//  FilterFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 31.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class FilterFactoryImplementation: FilterFactory {

    private var sectionNames = ["Разработка", "Marketing", "Something else"]

    func createFilters() -> [Filter] {
        return createSectionFilters()
    }

    private func createSectionFilters() -> [SectionFilter] {
        return sectionNames.map {
            let sectionFilter = SectionFilter()
            sectionFilter.title = $0
            return sectionFilter
        }
    }
}
