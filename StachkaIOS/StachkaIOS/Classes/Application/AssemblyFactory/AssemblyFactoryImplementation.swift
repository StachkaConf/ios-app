//
//  AssemblyFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class AssemblyFactoryImplementation: AssemblyFactory {
    func userStories() -> UserStoryAssembly {
        return UserStoryAssemblyImplementation()
    }
    
    func services() -> ServiceAssembly {
        return ServiceAssemblyImplementation()
    }

    func core() -> CoreAssembly {
        return CoreAssemblyImplementation()
    }

    func helpers() -> HelperAssembly {
        return HelperAssemblyImplementation()
    }

    func coordinators() -> CoordinatorAssembly {
        return CoordinatorAssemblyImplementation()
    }
}
