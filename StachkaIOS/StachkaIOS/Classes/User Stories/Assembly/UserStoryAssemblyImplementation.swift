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
        }
    }

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory =  assemblyFactory
    }

    func conferencesFeedModule() -> UIViewController {
        let storyboardId = Constants.StoryboardIds.conferences
        let storyboard = UIStoryboard(name: storyboardId, bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! FeedViewController
        let viewModel = FeedViewModelImplementation(view: viewController)
        viewController.viewModel = viewModel

        return viewController
    }

    func conferencesDetailModule() -> UIViewController {
        return UIViewController()
    }

    func conferencesFilterModule() -> UIViewController {
        return UIViewController()
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
