//
//  PresentationDateCombinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 08.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class PresentationDateCombinatorImplementation: PresentationDateCombinator {

    enum Constants {
        static let hourDifference = 1
    }

    func combineDates(in presentations: [Presentation]) -> [Presentation] {
        return presentations.map(combineDate)
    }

    private func combineDate(in presentation: Presentation) -> Presentation {
        let startDate = convertDate(fromDate: presentation.date,
                                    minutes: presentation.minutesFrom,
                                    hours: presentation.hoursFrom)
        let endDate = convertDate(fromDate: presentation.date,
                                  minutes: presentation.minutesTo,
                                  hours: presentation.hoursTo)

        presentation.actualStartDate = startDate
        presentation.actualEndDate = endDate

        return presentation
    }

    private func convertDate(fromDate date: NSDate, minutes: Int, hours: Int) -> NSDate {
        let calendar = Calendar.current
        var newDate = calendar.date(byAdding: .hour,
                                    value: hours - Constants.hourDifference,
                                    to: date as Date) ?? Date()
        newDate = calendar.date(byAdding: .minute,
                                value: minutes,
                                to: newDate) ?? Date()

        return newDate as NSDate
    }
}
