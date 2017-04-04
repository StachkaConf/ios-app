//
//  FavouritesCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class FavouritesCoordinatorImplemenation: FavouritesCoordinator, CoordinatorWithDependencies {
    private let rootNavigationController: UINavigationController
    private let userStoryAssemblyFactory: FavouritesAssemblyFactory

    var childCoordinators: [Coordinator] = []
    
    init(rootNavigationController: UINavigationController, userStoryAssemblyFactory: FavouritesAssemblyFactory) {
        self.rootNavigationController = rootNavigationController
        self.userStoryAssemblyFactory = userStoryAssemblyFactory
    }

    func start() {
        let favouritesModule = userStoryAssemblyFactory.favouritesAssembly().module()
        rootNavigationController.setViewControllers([favouritesModule], animated: false)
    }
}
