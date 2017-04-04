//
//  CoordinatorFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 04.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol CoordinatorFactory {
    func applicationCoordinatorFactory() -> ApplicationCoordinatorFactory
    func initialUserStoriesCoordinatorFactory() -> InitialUserStoriesCoordinatorsFactory
}
