//
//  UserStoryAssemblyImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class UserStoryAssemblyImplementation: UserStoryAssembly {

    enum Constants {
        enum StoryboardIds {
            static let conferences = "Conferences"
            static let main = "Main"
        }
    }

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory =  assemblyFactory
    }

    func onboardingModule() -> UIViewController {
        let viewController: OnboardingViewController = UIStoryboard
            .createController(withStoryboardId: Constants.StoryboardIds.main)

        return viewController
    }

    func conferencesFeedModule() -> UIViewController {
        let filterService = assemblyFactory.services().filterService()
        let presentationService = assemblyFactory.services().presentationService()
        let searchConfigurationFactory = assemblyFactory.helpers().searchConfigurationFactory()
        let viewController: FeedViewController =
            UIStoryboard.createController(withStoryboardId: Constants.StoryboardIds.conferences)
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
            UIStoryboard.createController(withStoryboardId: Constants.StoryboardIds.conferences)
        let viewModel = FiltersViewModelImplementation(view: viewController,
                                                       filterService: filterService,
                                                       filterFactory: filterFactory,
                                                       filterCellViewModelFactory: filterCellViewModelFactory)
        viewController.viewModel = viewModel

        return viewController
    }

    func tabBar() -> UITabBarController {
        return AppTabBarController()
    }

    func favouritesFeedModule() -> UIViewController {
        let storyboardId = Constants.StoryboardIds.conferences
        let storyboard = UIStoryboard(name: storyboardId, bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! FeedViewController
        let viewModel = FavouritesFeedViewModelImplementation(view: viewController)
        viewController.viewModel = viewModel
        // FIXME: это заглушка, чтобы проверить работу табов
        viewController.view.backgroundColor = UIColor.red

        return viewController
    }
}
