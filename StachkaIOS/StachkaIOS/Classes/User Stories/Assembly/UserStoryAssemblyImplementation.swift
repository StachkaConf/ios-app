//
//  UserStoryAssemblyImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class UserStoryAssemblyImplementation: UserStoryAssembly {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory =  assemblyFactory
    }


    func conferencesFeedModule() -> UIViewController {
        let filterService = assemblyFactory.services().filterService()
        let presentationService = assemblyFactory.services().presentationService()
        let searchConfigurationFactory = assemblyFactory.helpers().searchConfigurationFactory()
        let viewController: FeedViewController =
            UIStoryboard.createController(withStoryboardId: StoryboardName.reports)
        let viewModel = FeedViewModelImplementation(view: viewController,
                                                    filterService: filterService,
                                                    presentationService: presentationService,
                                                    searchConfigurationFactory: searchConfigurationFactory)
        viewController.viewModel = viewModel

        return viewController
    }

    func conferencesDetailModule() -> UIViewController {
        return UIViewController()
    }

    func conferencesFilterModule() -> UIViewController {
        let filterService = assemblyFactory.services().filterService()
        let filterFactory = assemblyFactory.helpers().filterFactory()
        let filterCellViewModelFactory = FilterCellViewModelFactoryImplementation()
        let viewController: FiltersViewController =
            UIStoryboard.createController(withStoryboardId: StoryboardName.reports)
        let viewModel = FiltersViewModelImplementation(view: viewController,
                                                       filterService: filterService,
                                                       filterFactory: filterFactory,
                                                       filterCellViewModelFactory: filterCellViewModelFactory)
        viewController.viewModel = viewModel

        return viewController
    }
}
