//
//  UserStoryAssemblyImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class UserStoryAssemblyImplementation: UserStoryAssembly {
    func filtersModuleAssembly() -> Assembly {
        return TemporaryAssembly()
    }

    func conferencesModuleAssembly() -> Assembly {
        return TemporaryAssembly()
    }

    func favouritesModuleAssembly() -> Assembly {
        return TemporaryAssembly()
    }

    func logoModuleAssembly() -> Assembly {
        return TemporaryAssembly()
    }
}
