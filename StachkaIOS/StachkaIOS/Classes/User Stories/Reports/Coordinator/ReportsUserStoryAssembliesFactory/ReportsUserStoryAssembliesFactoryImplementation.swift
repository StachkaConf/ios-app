//
//  ReportsUserStoryAssembliesFactoryImplementation.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ReportsUserStoryAssembliesFactoryImplementation: ReportsUserStoryAssembliesFactory {
    func reportsFeedAssembly() -> ModuleAssembly {
        return ReportsFeedAssembly()
    }
    
    func reportsFiltersAssembly() -> ModuleAssembly {
        return ReportsFiltersAssembly()
    }
}
