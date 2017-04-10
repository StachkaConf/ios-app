//
//  PresentationCell.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import SDWebImage

class PresentationInfoCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    func configure(with viewModel: CellViewModel) {
        guard let viewModel = viewModel as? PresentationInfoCellViewModel else {
            return
        }

        placeLabel.text = viewModel.place
        timeLabel.text = viewModel.dateString
        titleLabel.text = viewModel.title
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.preferredMaxLayoutWidth = contentView.frame.size.width - 40.0
    }
}
