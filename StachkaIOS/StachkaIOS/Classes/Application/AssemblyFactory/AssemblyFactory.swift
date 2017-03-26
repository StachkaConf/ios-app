//
//  AssemblyFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol Assembly {}

/// нужен только временно, чтобы не создавать сразу фабрики модулей
class TemporaryAssembly: Assembly {}

protocol AssemblyFactory {
    func userStories() -> UserStoryAssembly
    func services() -> ServiceAssembly
    func core() -> CoreAssembly
    func helpers() -> HelperAssembly
    func coordinators() -> CoordinatorAssembly
}

