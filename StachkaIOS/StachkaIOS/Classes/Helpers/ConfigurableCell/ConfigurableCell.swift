//
//  ConfigurableCell.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    static var identifier: String { get }

    func configure(with viewModel: CellViewModel)
}

extension ConfigurableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol ConfigurableStaticHeightCell: ConfigurableCell {
    static var cellHeight: CGFloat { get }
}

protocol CellViewModel {
    var associatedCell: ConfigurableCell.Type { get }
}
