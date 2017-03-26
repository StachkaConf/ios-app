//
//  ApplicationCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ApplicationCoordinatorImplementation: ApplicationCoordinator, CoordinatorWithDependencies {
    var childCoordinators: [Coordinator] = []
    let router: ApplicationRouter
    let assembly: AssemblyFactory

    init(router: ApplicationRouter, assembly: AssemblyFactory) {
        self.router = router
        self.assembly = assembly
    }

    func start() {}
}
