//
//  PresentationCellViewModel.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct PresentationInfoCellViewModel: CellViewModel {
    var associatedCell: ConfigurableCell.Type = PresentationInfoCell.self

    let dateString: String
    let title: String
    let place: String
    let section: String
}
