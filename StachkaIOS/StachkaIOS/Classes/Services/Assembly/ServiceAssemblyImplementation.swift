//
//  ServiceAssemblyImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RealmSwift

class ServiceAssemblyImplementation: ServiceAssembly {
    let assemblyFactory: AssemblyFactory
    lazy var realm = {
        return try! Realm()
    }()

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory =  assemblyFactory
    }

    func filterService() -> FilterService {
        return FilterServiceImplementation(realm: realm)
    }
}
