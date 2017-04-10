//
//  SectionCellViewModel.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 29.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct SectionFilterCellViewModel: FilterCellViewModel {
    var associatedCell: ConfigurableCell.Type = TickFilterCell.self
    var sectionName: String
    var selected: Bool = false
    var isBold: Bool = false
}

extension SectionFilterCellViewModel {
    init(sectionName: String, selected: Bool) {
        self.sectionName = sectionName
        self.selected = selected
    }
}
