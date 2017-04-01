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

    enum Constants {
        static let username = "application@nastachku.ru"
        static let password = "3V9q9414137qwpV3R9z35175c436G68g"
        static let timeoutInterval = 30.0
    }

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

    func presentations(with configuration: PresentationServcieConfiguration) -> Observable<[Presentation]> {

        do {
            let url = try urlBuilder.build(withAPIPath: .defaultPath,
                                           APIMethod: .products,
                                           configuration: configuration)
            let requestBuilderConfiguration = RequestBuilderConfiguration(method: .GET,
                                                                          timoutInterval: Constants.timeoutInterval,
                                                                          url: url,
                                                                          username: Constants.username,
                                                                          password: Constants.password)
            let request = requestBuilder.build(requestBuilderConfiguration)
            return networkClient
                .perform(request: request)
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                .map { [weak self] data in
                    guard let strongSelf = self else { return [] }
                    let deserialized = try strongSelf.jsonDeserializer.deserialize(data: data)

                    return [Presentation()]
                }

        } catch let error {
            return Observable<Presentation>.createWithError(error)
        }
    }
}
