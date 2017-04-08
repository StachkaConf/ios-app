//
//  HelperAssemblyImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class HelperAssemblyImplementation: HelperAssembly {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory =  assemblyFactory
    }

    func filterFactory() -> FilterFactory {
        return FilterFactoryImplementation()
    }

    func searchConfigurationFactory() -> SearchConfigurationFactory {
        return SearchConfigurationFactoryImplementation()
    }

    func presentationDateCombinator() -> PresentationDateCombinator {
        return PresentationDateCombinatorImplementation()
    }

    func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "ru_RU")
        let dateFormat = "HH:mm"
        let timeZone = TimeZone(abbreviation: "GMT+3")
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateFormat

        return dateFormatter
    }
}
