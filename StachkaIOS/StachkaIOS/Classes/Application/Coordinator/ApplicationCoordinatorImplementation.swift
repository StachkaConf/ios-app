//
//  ApplicationCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class ApplicationCoordinatorImplementation: ApplicationCoordinator, CoordinatorWithDependencies {
    var childCoordinators: [Coordinator] = []
    let assembly: AssemblyFactory
    weak var window: UIWindow?
    var tabBarController: UITabBarController?

    init(assembly: AssemblyFactory, window: UIWindow?) {
        self.assembly = assembly
        self.window = window
    }

    func start() {
        tabBarController = assembly.userStories().tabBar()
        let feed = assembly.userStories().conferencesFeedModule()
        embedInTabBarWithNavigationController(controller: feed)
        let conferencesCoordinator = assembly.coordinators().conferencesCoordinator(rootController: feed)
        add(coordinator: conferencesCoordinator)

        let favourites = assembly.userStories().favouritesFeedModule()
        embedInTabBarWithNavigationController(controller: favourites)
        let favouritesCoordinator = assembly.coordinators().favouritesCoordinator(rootController: favourites)
        add(coordinator: favouritesCoordinator)

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        conferencesCoordinator.start()
        favouritesCoordinator.start()
    }

    private func embedInTabBarWithNavigationController(controller: UIViewController) {
        let navigationController = UINavigationController(rootViewController: controller)
        tabBarController?.embed(viewController: navigationController)
    }
}
