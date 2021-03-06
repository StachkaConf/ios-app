//
//  CoreAssemblyImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class CoreAssemblyImplementation: CoreAssembly {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory =  assemblyFactory
    }

    func realmConfigurator() -> RealmConfigurator {
        return RealmConfiguratorImplementation()
    }
    
    func networkClient() -> NetworkClient {
        return NetworkClientImplementation(session: URLSession.shared)
    }

    func requestBuilder() -> RequestBuilder {
        return RequestBuilderImplementation()
    }

    func urlBuilder() -> URLBuilder {
        return URLBuilderImplementation()
    }

    func jsonDeserializer() -> Deserializer {
        return JSONDeserializer()
    }

    func realmStorage() -> RealmStorage {
        return RealmStorageImplementation()
    }

    func presentationMapper() -> PresentationMapper {
        return PresentationMapperImplementation()
    }
}
