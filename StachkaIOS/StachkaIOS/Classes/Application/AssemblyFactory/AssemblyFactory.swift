//
//  AssemblyFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol Assembly {}

protocol AssemblyFactory {
    func services() -> ServiceAssembly
    func core() -> CoreAssembly
    func helpers() -> HelperAssembly
    func userStory() -> UserStoryAssemblyFactory
    func coordinators() -> CoordinatorFactory
}

