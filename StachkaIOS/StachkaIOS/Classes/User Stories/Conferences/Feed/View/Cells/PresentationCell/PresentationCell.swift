//
//  PresentationCell.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class PresentationCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var titleLabel: UILabel!
    func configure(with viewModel: CellViewModel) {
        guard let viewModel = viewModel as? PresentationCellViewModel else {
            return
        }

        titleLabel.text = viewModel.title
    }
}
