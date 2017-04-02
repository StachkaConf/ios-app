//
//  FavouritesCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class FavouritesCoordinatorImplemenation: FavouritesCoordinator, CoordinatorWithDependencies {
    weak var rootController: UITabBarController?
    let moduleAssembly: ModuleAssembly

    var childCoordinators: [Coordinator] = []
    
    init(rootTabBarController: UITabBarController, moduleAssembly: ModuleAssembly) {
        self.rootController = rootTabBarController
        self.moduleAssembly = moduleAssembly
    }

    func start() {
        let nc = UINavigationController(rootViewController: moduleAssembly.module())
        self.rootController?.embed(viewController: nc)
    }
}
