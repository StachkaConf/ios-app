//
//  UserStoryAssembly.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol UserStoryAssembly: Assembly {
    func filtersModuleAssembly() -> Assembly
    func conferencesModuleAssembly() -> Assembly
    func favouritesModuleAssembly() -> Assembly
    func logoModuleAssembly() -> Assembly
}
