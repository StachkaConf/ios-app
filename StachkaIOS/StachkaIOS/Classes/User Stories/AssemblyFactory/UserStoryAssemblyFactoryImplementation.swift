//
//  UserStoryAssemblyFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 04.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class UserStoryAssemblyFactoryImplementation: UserStoryAssemblyFactory {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func talksAssemblyFactory() -> TalksUserStoryAssemblyFactory {
        return TalksUserStoryAssemblyFactoryImplementation(assemblyFactory: assemblyFactory)
    }
    
    func favouritesAssemblyFactory() -> FavouritesAssemblyFactory {
        return FavouritesAssemblyFactoryImplementation(assemblyFactory: assemblyFactory)
    }

    func onboardingAssembly() -> OnboardingAssembly {
        return OnboardingAssembly()
    }
}
