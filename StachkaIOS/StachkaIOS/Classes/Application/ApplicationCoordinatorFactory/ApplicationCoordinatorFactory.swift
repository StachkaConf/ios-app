//
//  ApplicationCoordinatorFactory.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 01/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinatorFactory {
    func applicationCoordinator(window: UIWindow) -> ApplicationCoordinator {
        let tabBarController = AppTabBarController()
        let onboardingModuleAssembly = OnboardingAssembly()
        let initialUserStoriesCoordinatorsFactory = InitialUserStoriesCoordinatorsFactoryImplementation()
        
        return ApplicationCoordinatorImplementation(window: window,
                                                    rootTabBarController: tabBarController,
                                                    onboardingModuleAssembly: onboardingModuleAssembly,
                                                    initialUserStoriesCoordinatorsFactory: initialUserStoriesCoordinatorsFactory)
    }
}
