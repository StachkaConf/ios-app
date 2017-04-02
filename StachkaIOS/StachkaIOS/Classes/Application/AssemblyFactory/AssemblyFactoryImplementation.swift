//
//  AssemblyFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class AssemblyFactoryImplementation: AssemblyFactory {    
    func services() -> ServiceAssembly {
        return ServiceAssemblyImplementation(assemblyFactory: self)
    }

    func core() -> CoreAssembly {
        return CoreAssemblyImplementation(assemblyFactory: self)
    }

    func helpers() -> HelperAssembly {
        return HelperAssemblyImplementation(assemblyFactory: self)
    }
}
