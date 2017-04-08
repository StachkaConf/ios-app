//
//  FilterServiceImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 30.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm

class FilterServiceImplementation: FilterService {

    let realm: Realm
    init(realm: Realm) {
        self.realm = realm
    }

    func save(_ filters: [Filter]) -> Observable<Void> {
        let keys = filters
            .flatMap { $0 as? AutoObject }
            .map { $0.compoundKey }

        return Observable.create { observer in
            guard let backgroundRealm = try? Realm() else {
                observer.onCompleted()
                return Disposables.create()
            }
            let filterObjects = keys
                .flatMap { backgroundRealm.object(ofType: AutoObject.self, forPrimaryKey: $0) }
            do {
                try backgroundRealm.write {
                    backgroundRealm.add(filterObjects)
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }

    func saveNew(_ filters: [Filter]) -> Observable<Void> {
        return Observable.create { observer in
            guard let backgroundRealm = try? Realm() else {
                observer.onCompleted()
                return Disposables.create()
            }
            let filterObjects = filters.flatMap { $0 as? AutoObject }
            do {
                try backgroundRealm.write {
                    backgroundRealm.add(filterObjects)
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }

    func deleteAndSave(_ filters: [Filter]) -> Observable<Void> {
        var types: [AnyClass] = []
        filters.forEach { element in
            if !types.contains(where: { $0 == type(of: element) }) {
                types.append(type(of: element))
            }
        }
        
        return Observable.create { observer in
            guard let backgroundRealm = try? Realm() else {
                observer.onCompleted()
                return Disposables.create()
            }
            let filterObjects = filters.flatMap { $0 as? AutoObject }
            do {
                try backgroundRealm.write {
                    types
                        .flatMap { $0 as? Object.Type }
                        .forEach { backgroundRealm.delete(backgroundRealm.objects($0)) }
                    backgroundRealm.add(filterObjects)
                }
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }

    func updateFilters(_ types: [Object.Type]) -> Observable<[Filter]> {
        let filterTypes = types.filter { $0 is Filter.Type }
        var observables: [Observable<[Object]>] = []
        filterTypes.forEach {
            let observable = Observable.array(from: realm.objects($0))
            observables.append(observable)
        }
        let concatSequence = Observable.concat(observables)
        return concatSequence.map { $0.flatMap { $0 as? Filter } }
    }
}
