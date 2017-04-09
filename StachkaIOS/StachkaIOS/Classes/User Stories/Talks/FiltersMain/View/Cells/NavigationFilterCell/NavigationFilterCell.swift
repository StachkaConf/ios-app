//
//  TickFilterCell.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 29.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class NavigationFilterCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var filterLabel: UILabel!
    func configure(with viewModel: CellViewModel) {
        guard let viewModel = viewModel as? SectionFilterCellViewModel else {
            return
        }

        filterLabel.text = viewModel.sectionName
    }
}
