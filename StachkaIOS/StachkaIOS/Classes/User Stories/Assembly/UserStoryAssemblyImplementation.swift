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

    func feedModule() -> UIViewController {
        let storyboardId = Constants.StoryboardIds.conferences
        let storyboard = UIStoryboard(name: storyboardId, bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController()!

        return viewController
    }

    func detailModule() -> UIViewController {
        return UIViewController()
    }

    func filterModule() -> UIViewController {
        return UIViewController()
    }

    func tabBar() -> UITabBarController {
        return AppTabBarController()
    }
}
