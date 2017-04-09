//
//  PresentationCellViewModel.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct PresentationCellViewModel: CellViewModel {
    var associatedCell: ConfigurableCell.Type = PresentationCell.self

    let title: String
    let authorImageUrl: String
    let category: String
    let place: String
}
