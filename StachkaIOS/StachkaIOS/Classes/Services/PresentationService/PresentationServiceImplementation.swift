//
//  PresentationServiceImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 01.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm
import RealmSwift

class PresentationServcieImplementation: PresentationService {

    enum Constants {
        static let username = "application@nastachku.ru"
        static let password = "3V9q9414137qwpV3R9z35175c436G68g"
        static let timeoutInterval = 30.0
        static let defaultConfiguration = PresentationServcieConfiguration(itemsPerPage: 300,
                                                                           sortParameter: nil,
                                                                           startingPage: nil)
    }

    let urlBuilder: URLBuilder
    let jsonDeserializer: Deserializer
    let requestBuilder: RequestBuilder
    let networkClient: NetworkClient
    let realmStorage: RealmStorage
    let presentationMapper: PresentationMapper
    let dateCombinator: PresentationDateCombinator

    let realm = try! Realm()

    init(urlBuilder: URLBuilder,
         jsonDeserializer: Deserializer,
         requestBuilder: RequestBuilder,
         networkClient: NetworkClient,
         realmStorage: RealmStorage,
         presentationMapper: PresentationMapper,
         dateCombinator: PresentationDateCombinator) {
        self.urlBuilder = urlBuilder
        self.jsonDeserializer = jsonDeserializer
        self.requestBuilder = requestBuilder
        self.networkClient = networkClient
        self.realmStorage = realmStorage
        self.presentationMapper = presentationMapper
        self.dateCombinator = dateCombinator
    }

    func updatePresentationsAndSave() -> Observable<Void> {
        return updatePresentationsAndSave(with: Constants.defaultConfiguration)
    }

    func updatePresentationsAndSave(with configuration: PresentationServcieConfiguration) -> Observable<Void> {

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
            return requestDataAndSave(request)
        } catch let error {
            return Observable<Presentation>.createWithError(error)
        }
    }

    func presentationsUpdated() -> Observable<Void> {
        return Observable.changeset(from: realm.objects(Presentation.self)).map { _ in return }
    }

    func filteredPresentations(with: [Filter]) -> Observable<[Presentation]> {
        return Observable.create { [weak self] observer in
            guard let strongSelf = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            observer.onNext(strongSelf.realm.objects(Presentation.self).toArray())
            observer.onCompleted()
            return Disposables.create()
        }
    }

    private func requestDataAndSave(_ request: URLRequest) -> Observable<Void> {
         return networkClient
            .perform(request: request)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .map { [weak self] (data: Data) -> [Presentation] in
                guard let strongSelf = self else { return [] }

                let deserialized = try strongSelf.jsonDeserializer.deserialize(data: data) as? [String: Any]
                let mapped = strongSelf.presentationMapper.mapArray(deserialized?["products"])
                return strongSelf.dateCombinator.combineDates(in: mapped)
            }
            .flatMap { [weak self] (objects: [Presentation]) -> Observable<Void> in
                return self?.realmStorage.replaceAll(objects) ?? Observable.empty()
            }
    }
}
