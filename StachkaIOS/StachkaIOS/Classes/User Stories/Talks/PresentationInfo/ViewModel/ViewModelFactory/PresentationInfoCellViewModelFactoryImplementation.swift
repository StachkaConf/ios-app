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
        guard let author = presentation.author else {
            return []
        }

        let authorImageCellViewModel = AuthorImageCellViewModel(associatedCell: AuthorImageCell.self,
                                                                authorImageUrl: author.imageUrlString, category: presentation.category)
        let authorBriefInfoCellViewModel = AuthorBriefInfoCellViewModel(associatedCell: AuthorBriefInfoCell.self,
                                                                        name: author.name,
                                                                        position: author.position,
                                                                        city: author.city)
        let presentationInfoCellViewModel = PresentationInfoCellViewModel(associatedCell: PresentationInfoCell.self,
                                                                          dateString: dateFormatter.string(from: presentation.actualStartDate as Date),
                                                                          title: presentation.presentationName,
                                                                          place: presentation.place,
                                                                          section: presentation.section)
        let presentationDescriptionCellViewModel = PresentationDescriptionCellViewModel(associatedCell: PresentationDescriptionCell.self,
                                                                                        fullDescription: parsedHtml(from: presentation.fullDescription))
        let authorInfoCellViewModel = AuthorInfoCellViewModel(associatedCell: AuthorInfoCell.self,
                                                              fullDescription: parsedHtml(from: author.fullDescription),
                                                              phone: author.phone,
                                                              email: author.email)

        return [authorImageCellViewModel, authorBriefInfoCellViewModel, presentationInfoCellViewModel, presentationDescriptionCellViewModel, authorInfoCellViewModel]

    }

    private func parsedHtml(from string: String) -> String {
        if let html = HTML(html: string, encoding: .utf8) {
            return html.body?.text ?? ""
        }
        return string
    }
}
