//
//  PresentationCell.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import SDWebImage

class AuthorInfoCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!

    func configure(with viewModel: CellViewModel) {
        guard let viewModel = viewModel as? AuthorInfoCellViewModel else {
            return
        }
        descriptionLabel.text = viewModel.fullDescription
        emailButton.setTitle(viewModel.email, for: .normal)
        phoneButton.setTitle(viewModel.phone, for: .normal)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionLabel.preferredMaxLayoutWidth = contentView.frame.size.width - 40.0
    }
}
