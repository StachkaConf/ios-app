//
//  TalksUserStoryAssemblyFactoryImplementation.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class TalksUserStoryAssemblyFactoryImplementation: TalksUserStoryAssemblyFactory {
    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func talksFeedAssembly() -> ModuleAssembly {
        return TalksFeedAssembly(assemblyFactory: assemblyFactory)
    }

    func talksFiltersMainAssembly() -> ModuleAssembly {
        return TalksFiltersMainAssembly(assemblyFactory: assemblyFactory)
    }
    
    func talksFiltersAssembly() -> FilterAssembly {
        return TalksFiltersAssembly(assemblyFactory: assemblyFactory)
    }
}
