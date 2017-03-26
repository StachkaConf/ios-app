//
//  ConferencesCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class ConferencesCoordinatorImplementation: ConferencesCoordinator {

    private let rootController: UIViewController
    private let assembly: AssemblyFactory

    init(assembly: AssemblyFactory, rootController: UIViewController) {
        self.rootController = rootController
        self.assembly = assembly
    }

    func start() {
        
    }
}
