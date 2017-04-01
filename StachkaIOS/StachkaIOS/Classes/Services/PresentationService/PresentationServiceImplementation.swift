//
//  PresentationServiceImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 01.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift

class PresentationServcieImplementation: PresentationService {

    let urlBuilder: URLBuilder
    let jsonDeserializer: Deserializer
    let requestBuilder: RequestBuilder
    let networkClient: NetworkClient

    init(urlBuilder: URLBuilder,
         jsonDeserializer: Deserializer,
         requestBuilder: RequestBuilder,
         networkClient: NetworkClient) {
        self.urlBuilder = urlBuilder
        self.jsonDeserializer = jsonDeserializer
        self.requestBuilder = requestBuilder
        self.networkClient = networkClient
    }

    func presentations(with configuration: PresentationServcieConfiguration) -> Observable<Presentation> {

        do {
            let url = try urlBuilder.build(withAPIPath: NetworkRequestConstants.APIPath.defaultPath,
                                           APIMethod: NetworkRequestConstants.APIMethodName.products,
                                           configuration: configuration)
            let requestBuilderConfiguration = RequestBuilderConfiguration(method: .GET,
                                                                          timoutInterval: 30.0,
                                                                          url: url)
            let request = requestBuilder.build(requestBuilderConfiguration)
            return networkClient
                .perform(request: request)
                .map { [weak self] data in
                    guard let strongSelf = self else { return Presentation() }
                    let deserialized = try strongSelf.jsonDeserializer.deserialize(data: data)

                    return Presentation()
                }

        } catch let error {
            return Observable<Presentation>.createWithError(error)
        }
    }
}
