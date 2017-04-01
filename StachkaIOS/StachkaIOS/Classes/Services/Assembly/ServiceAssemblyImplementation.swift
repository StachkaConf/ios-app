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
        self.assemblyFactory = assemblyFactory
    }

    func filterService() -> FilterService {
        return FilterServiceImplementation(realm: realm)
    }

    func presentationService() -> PresentationService {
        let urlBuilder = assemblyFactory.core().urlBuilder()
        let jsonDeserializer = assemblyFactory.core().jsonDeserializer()
        let networkClient = assemblyFactory.core().networkClient()
        let requestBuilder = assemblyFactory.core().requestBuilder()

        return PresentationServcieImplementation(urlBuilder: urlBuilder,
                                                 jsonDeserializer: jsonDeserializer,
                                                 requestBuilder: requestBuilder,
                                                 networkClient: networkClient)
    }
}
