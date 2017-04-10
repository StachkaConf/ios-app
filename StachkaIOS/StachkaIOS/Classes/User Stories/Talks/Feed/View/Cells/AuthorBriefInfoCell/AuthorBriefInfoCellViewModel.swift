//
//  PresentationCellViewModel.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct AuthorBriefInfoCellViewModel: CellViewModel {
    var associatedCell: ConfigurableCell.Type = AuthorBriefInfoCell.self

    let name: String
    let position: String
    let city: String
}
