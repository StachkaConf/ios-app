//
//  PresentationCellViewModel.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct AuthorInfoCellViewModel: CellViewModel {
    var associatedCell: ConfigurableCell.Type = AuthorInfoCell.self

    let fullDescription: String
    let phone: String
    let email: String
}
