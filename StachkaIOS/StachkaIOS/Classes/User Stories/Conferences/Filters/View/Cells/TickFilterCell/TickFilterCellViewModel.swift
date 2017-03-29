//
//  TickFilterCellViewModel.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 29.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct TickFilterCellViewModel: CellViewModel {
    var associatedCell: ConfigurableCell.Type = TickFilterCell.self

    var selected: Bool
    let title: String
}
