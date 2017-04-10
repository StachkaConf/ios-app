//
//  PresentationInfoViewModelFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 10.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import Kanna

class PresentationInfoCellViewModelFactoryImplementation: PresentationInfoCellViewModelFactory {

    let dateFormatter: DateFormatter

    init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }

    func section(from presentation: Presentation) -> CellSectionModel {
        let sectionModel = CellSectionModel(items: viewModels(from: presentation))
        return sectionModel
    }

    private func viewModels(from presentation: Presentation) -> [CellViewModel] {
        var cellViewModels: [CellViewModel] = []

        let authorImageCellViewModel = AuthorImageCellViewModel(associatedCell: AuthorImageCell.self,
                                                                authorImageUrl: presentation.author?.imageUrlString ?? "", category: presentation.category)
        cellViewModels.append(authorImageCellViewModel)
        if let author = presentation.author {
            let authorBriefInfoCellViewModel = AuthorBriefInfoCellViewModel(associatedCell: AuthorBriefInfoCell.self,
                                                                            name: author.name,
                                                                            position: author.position,
                                                                            city: author.city)
            cellViewModels.append(authorBriefInfoCellViewModel)
        }

        let presentationInfoCellViewModel = PresentationInfoCellViewModel(associatedCell: PresentationInfoCell.self,
                                                                          dateString: dateFormatter.string(from: presentation.actualStartDate as Date),
                                                                          title: presentation.presentationName,
                                                                          place: presentation.place,
                                                                          section: presentation.section)
        cellViewModels.append(presentationInfoCellViewModel)
        let presentationDescriptionCellViewModel = PresentationDescriptionCellViewModel(associatedCell: PresentationDescriptionCell.self,
                                                                                        fullDescription: parsedHtml(from: presentation.fullDescription))
        cellViewModels.append(presentationDescriptionCellViewModel)

        if let author = presentation.author {
            let authorInfoCellViewModel = AuthorInfoCellViewModel(associatedCell: AuthorInfoCell.self,
                                                                  fullDescription: parsedHtml(from: author.fullDescription),
                                                                  phone: author.phone,
                                                                  email: author.email)
            cellViewModels.append(authorInfoCellViewModel)
        }

        return cellViewModels
    }

    private func parsedHtml(from string: String) -> String {
        if let html = HTML(html: string, encoding: .utf8) {
            return html.body?.text ?? ""
        }
        return string
    }
}
