//
//  FavouritesAssemblyFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 04.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class FavouritesAssemblyFactoryImplementation: FavouritesAssemblyFactory {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func favouritesAssembly() -> ModuleAssembly {
        return FavouritesFeedAssembly(assemblyFactory: assemblyFactory)
    }
}
