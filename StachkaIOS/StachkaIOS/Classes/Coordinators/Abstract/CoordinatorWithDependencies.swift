//
//  CoordinatorWithDependencies.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol CoordinatorWithDependencies {
    var childCoordinators: [Coordinator] { get set }

    mutating func add(coordinator: Coordinator)
    mutating func remove(coordinator: Coordinator?)
}

extension CoordinatorWithDependencies {
    mutating func add(coordinator: Coordinator) {
        if !childCoordinators.contains { return coordinator === $0 } {
            childCoordinators.append(coordinator)
        }
    }

    mutating func remove(coordinator: Coordinator?) {
        guard let coordinator = coordinator,
            let index = childCoordinators.index(where: { coordinator === $0 })
            else {
                return
        }
        childCoordinators.remove(at: index)
    }
}
