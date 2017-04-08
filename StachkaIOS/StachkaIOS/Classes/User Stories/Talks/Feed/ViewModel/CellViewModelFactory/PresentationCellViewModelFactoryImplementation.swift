//
//  PresentationCellViewModelFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 08.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class PresentationCellViewModelFactoryImplementation: PresentationCellViewModelFactory {

    let dateFormatter: DateFormatter

    init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }

    func sections(from presentations: [Presentation]) -> [PresentationSectionModel] {
        guard presentations.count > 0 else { return [] }

        let sortedPresentations = presentations.sorted(by: { first, second in
            first.actualStartDate.compare(second.actualStartDate as Date) == .orderedAscending
        })
        var sectionModels: [PresentationSectionModel] = []
        var currentDate = sortedPresentations[0].actualStartDate
        var currentModel = PresentationSectionModel(timeString: dateFormatter.string(from: currentDate as Date),
                                                    items: [])


        for presentation in sortedPresentations {
            let viewModel = presentationViewModel(from: presentation)
            if currentDate == presentation.actualStartDate {
                currentModel.items.append(viewModel)
            } else {
                sectionModels.append(currentModel)
                currentDate = presentation.actualStartDate
                currentModel = PresentationSectionModel(timeString: dateFormatter.string(from: currentDate as Date),
                                                        items: [viewModel])
            }
        }

        return sectionModels
    }

    private func presentationViewModel(from presentation: Presentation) -> PresentationCellViewModel {
        return PresentationCellViewModel(associatedCell: PresentationCell.self,
                                         title: presentation.presentationName,
                                         description: presentation.fullDescription)

    }
}
