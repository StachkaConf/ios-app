//
//  CoordinatorAssemblyImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class CoordinatorAssemblyImplementation: CoordinatorAssembly {
    func applicationCoordinator(window: UIWindow) -> ApplicationCoordinator {
        let tabBarController = AppTabBarController()
        let router = ApplicationRouterImplementation(window: window, tabBarEmbedding: tabBarController)
        return ApplicationCoordinatorImplementation(router: router, assembly: AssemblyFactoryImplementation())
    }
}
