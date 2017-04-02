//
//  CoordinatorAssemblyImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class CoordinatorAssemblyImplementation: CoordinatorAssembly {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory =  assemblyFactory
    }

    func conferencesCoordinator(rootController: UIViewController) -> ConferencesCoordinator {
        return ConferencesCoordinatorImplementation(assembly: assemblyFactory, rootController: rootController)
    }

}
