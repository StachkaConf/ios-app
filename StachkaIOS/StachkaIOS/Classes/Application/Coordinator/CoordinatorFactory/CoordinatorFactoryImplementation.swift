//
//  CoordinatorFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 04.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class CoordinatorFactoryImplementation: CoordinatorFactory {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func applicationCoordinatorFactory() -> ApplicationCoordinatorFactory {
        return ApplicationCoordinatorFactoryImplementation(assemblyFactory: assemblyFactory)
    }
    
    func initialUserStoriesCoordinatorFactory() -> InitialUserStoriesCoordinatorsFactory {
        return InitialUserStoriesCoordinatorsFactoryImplementation(assemblyFactory: assemblyFactory)
    }
}
