//
//  InitialUserStoriesCoordinatorsFactoryImplementation.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 01/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class InitialUserStoriesCoordinatorsFactoryImplementation: InitialUserStoriesCoordinatorsFactory {
    func reportsCoordinator(rootTabBarController: UITabBarController) -> ReportsCoordinator {
        return ReportsCoordinatorImplementation(assembly: AssemblyFactoryImplementation(), rootController: rootTabBarController)
    }
    
    func favouritesCoordinator(rootTabBarController: UITabBarController) -> FavouritesCoordinator {
        let moduleAssembly = FavouritesFeedAssembly()
        
        return FavouritesCoordinatorImplemenation(rootTabBarController: rootTabBarController,
                                                  moduleAssembly: moduleAssembly)
    }
}
