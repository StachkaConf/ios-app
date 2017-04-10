//
//  PresentationCell.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import SDWebImage

class PresentationDescriptionCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(with viewModel: CellViewModel) {
        guard let viewModel = viewModel as? PresentationDescriptionCellViewModel else {
            return
        }

        descriptionLabel.text = viewModel.fullDescription
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionLabel.preferredMaxLayoutWidth = contentView.frame.size.width - 40.0
    }
}
