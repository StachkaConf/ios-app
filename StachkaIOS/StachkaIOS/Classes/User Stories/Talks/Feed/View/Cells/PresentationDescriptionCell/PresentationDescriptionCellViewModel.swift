//
//  PresentationCellViewModel.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct PresentationDescriptionCellViewModel: CellViewModel {
    var associatedCell: ConfigurableCell.Type = PresentationDescriptionCell.self

    let fullDescription: String
}
