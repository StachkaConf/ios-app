//
//  FavouritesCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class FavouritesCoordinatorImplemenation: FavouritesCoordinator, CoordinatorWithDependencies {
    var childCoordinators: [Coordinator] = []
    weak var rootController: UIViewController?
    let assembly: AssemblyFactory

    init(assembly: AssemblyFactory, rootController: UIViewController) {
        self.assembly = assembly
        self.rootController = rootController
    }

    func start() {}
}
