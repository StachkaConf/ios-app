//
//  PresentationCell.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import Kingfisher

class PresentationCell: UITableViewCell, ConfigurableStaticHeightCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var authorImageView: UIImageView!

    static var cellHeight: CGFloat = 128.0

    func configure(with viewModel: CellViewModel) {
        guard let viewModel = viewModel as? PresentationCellViewModel else {
            return
        }
        categoryImageView.image = categoryImage(from: viewModel.category)
        categoryImageView.alpha = 0.3
        setAuthorImage(viewModel.authorImageUrl)
        titleLabel.text = viewModel.title
        //descriptionLabel.text = viewModel.description
    }

    func categoryImage(from category: String) -> UIImage? {
        switch category {
        case "Разработка":
            return UIImage.Categories.development

        case "Digital-маркетинг":
            return UIImage.Categories.marketing

        case "Образование и карьера":
            return UIImage.Categories.education

        case "Бизнес":
            return UIImage.Categories.business
        default:
            return nil
        }
    }

    func setAuthorImage(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        authorImageView.kf.setImage(with: url,
                                    placeholder: UIImage.placeholder,
                                    options: nil,
                                    progressBlock: nil,
                                    completionHandler: nil)
    }
}
