//
//  PresentationCell.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import SDWebImage

class AuthorBriefInfoCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!

    func configure(with viewModel: CellViewModel) {
        guard let viewModel = viewModel as? AuthorBriefInfoCellViewModel else {
            return
        }
        nameLabel.text = viewModel.name
        cityLabel.text = viewModel.city
        positionLabel.text = (viewModel.position == "") ? "Участник конференции" : viewModel.position
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        positionLabel.preferredMaxLayoutWidth = contentView.frame.size.width - 40.0
    }
}
