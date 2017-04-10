//
//  PresentationCell.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import SDWebImage

class AuthorImageCell: UITableViewCell, ConfigurableStaticHeightCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var authorImageView: UIImageView!

    static var cellHeight: CGFloat = 240.0

    override func awakeFromNib() {
        super.awakeFromNib()
        authorImageView.image = UIImage.placeholder
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        authorImageView.image = UIImage.placeholder
    }

    func configure(with viewModel: CellViewModel) {
        guard let viewModel = viewModel as? AuthorImageCellViewModel else {
            return
        }
        categoryImageView.image = categoryImage(from: viewModel.category)
        categoryImageView.alpha = 0.3
        setAuthorImage(viewModel.authorImageUrl)
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
        authorImageView.sd_setImage(with: url, placeholderImage: UIImage.placeholder)
    }
}
