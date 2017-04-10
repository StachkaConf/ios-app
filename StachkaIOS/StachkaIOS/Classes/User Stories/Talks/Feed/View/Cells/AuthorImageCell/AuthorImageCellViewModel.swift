//
//  PresentationCellViewModel.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct AuthorImageCellViewModel: CellViewModel {
    var associatedCell: ConfigurableCell.Type = AuthorImageCell.self

    let authorImageUrl: String
    let category: String
}
