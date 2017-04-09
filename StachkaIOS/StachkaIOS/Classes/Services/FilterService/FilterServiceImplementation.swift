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

    func change(_ filters: [Filter], using values: [Bool]) -> Observable<Void> {
        let filterObjectKeys = filters.flatMap { $0 as? AutoObject }.map { $0.compoundKey }
        let filterObjectTypes = filters.map { type(of: $0) }

        return Observable.create { observer in
            guard let backgroundRealm = try? Realm() else {
                observer.onCompleted()
                return Disposables.create()
            }
            let zipped = zip(filterObjectKeys, filterObjectTypes)
            let backgroundObjects = zipped.flatMap { backgroundRealm.object(ofType: $1 as! Object.Type,
                                                                            forPrimaryKey: $0) as? Filter }
            do {
                try backgroundRealm.write {
                    for (offset, object) in backgroundObjects.enumerated() {
                        object.selected = values[offset]
                    }
                    backgroundRealm.add(backgroundObjects as! [Object], update: true)
                }
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }

    func updateFilters() -> Observable<[Filter]> {
        let categoryFilters = Observable.array(from: realm.objects(CategoryFilter.self))
        let allPlacesFilter = Observable.array(from: realm.objects(AllPlacesFilter.self))
        let combinedFilters = Observable<[Filter]>
            .combineLatest(categoryFilters,
                           allPlacesFilter)
            { categories, places in
                let allFilters: [Filter] = (categories as [Filter]) + (places as [Filter])
                return allFilters
        }

        return combinedFilters
    }
}
