//
//  ReportsUserStoryAssembliesFactory.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol ReportsUserStoryAssembliesFactory {
    func reportsFeedAssembly() -> ModuleAssembly
    func reportsFiltersAssembly() -> ModuleAssembly
}
