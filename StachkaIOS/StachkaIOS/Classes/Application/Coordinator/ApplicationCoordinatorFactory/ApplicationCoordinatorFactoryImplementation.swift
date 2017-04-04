//
//  ApplicationCoordinatorFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 04.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class ApplicationCoordinatorFactoryImplementation: ApplicationCoordinatorFactory {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func applicationCoordinator(window: UIWindow) -> ApplicationCoordinator {
        let tabBarController = AppTabBarController()
        let onboardingModuleAssembly = assemblyFactory.userStory().onboardingAssembly()
        let initialUserStoriesCoordinatorsFactory = assemblyFactory.coordinators().initialUserStoriesCoordinatorFactory()

        return ApplicationCoordinatorImplementation(window: window,
                                                    rootTabBarController: tabBarController,
                                                    onboardingModuleAssembly: onboardingModuleAssembly,
                                                    initialUserStoriesCoordinatorsFactory: initialUserStoriesCoordinatorsFactory)
    }
}
