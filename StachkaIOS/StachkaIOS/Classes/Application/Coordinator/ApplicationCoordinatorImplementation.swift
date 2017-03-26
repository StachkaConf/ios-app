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
        let feed = assembly.userStories().feedModule()
        let navigationController = UINavigationController(rootViewController: feed)
        tabBarController?.embed(viewController: navigationController)
        let conferencesCoordinator = assembly.coordinators().conferencesCoordinator(rootController: feed)
        add(coordinator: conferencesCoordinator)

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        conferencesCoordinator.start()
    }
}
