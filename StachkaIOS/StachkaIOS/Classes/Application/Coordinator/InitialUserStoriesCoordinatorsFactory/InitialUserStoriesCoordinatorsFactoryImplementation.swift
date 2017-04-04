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
    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func talksCoordinator(rootNavigationController: UINavigationController) -> TalksCoordinator {
        let talksUserStoryAssemblyFactory = assemblyFactory.userStory().talksAssemblyFactory()
        return TalksCoordinatorImplementation(rootNavigationController: rootNavigationController,
                                              talksUserStoryAssemblyFactory: talksUserStoryAssemblyFactory)
    }
    
    func favouritesCoordinator(rootNavigationController: UINavigationController) -> FavouritesCoordinator {
        let userStoryAssemblyFactory = assemblyFactory.userStory().favouritesAssemblyFactory()
        
        return FavouritesCoordinatorImplemenation(rootNavigationController: rootNavigationController,
                                                  userStoryAssemblyFactory: userStoryAssemblyFactory)
    }
}
