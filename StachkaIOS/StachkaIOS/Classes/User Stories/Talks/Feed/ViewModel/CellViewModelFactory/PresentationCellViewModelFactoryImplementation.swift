//
//  PresentationCellViewModelFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 08.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class PresentationCellViewModelFactoryImplementation: PresentationCellViewModelFactory {

    enum Constants {
        static let barrierDate = Date(timeIntervalSince1970: 1492142400)
    }

    let dateFormatter: DateFormatter

    init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }

    func sections(from presentations: [Presentation]) -> [PresentationSectionModel] {
        guard presentations.count > 0 else { return [] }

        let sortedPresentations = presentations
            .sorted {
                ($0.actualStartDate as Date) < ($1.actualStartDate as Date)
            }
            .filter {
                $0.actualStartDate as Date >= Constants.barrierDate
            }

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
