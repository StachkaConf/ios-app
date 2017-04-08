//
//  RealmStorageImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 07.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm
import RealmSwift

class RealmStorageImplementation: RealmStorage {
    func saveAndReturnOnMain<T: AutoObject>(_ objects: [T]) -> Observable<[T]> {
        return Observable.create { observer in
            guard let backgroundRealm = try? Realm() else {
                observer.onCompleted()
                return Disposables.create()
            }
            do {
                try backgroundRealm.write {
                    backgroundRealm.add(objects)
                }
                observer.onNext(objects.map { return $0.compoundKey })
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
            }
            .observeOn(MainScheduler.instance)
            .map(takeFromRealm)
    }

    func replaceAllAndReturnOnMain<T: AutoObject>(_ objects: [T]) -> Observable<[T]> {
        objects.forEach {
            print($0.description)
        }
        return Observable.create { observer in
            guard let backgroundRealm = try? Realm() else {
                observer.onCompleted()
                return Disposables.create()
            }
            do {
                try backgroundRealm.write {
                    let oldObjects = backgroundRealm.objects(T.self)
                    backgroundRealm.delete(oldObjects)
                    backgroundRealm.add(objects)
                }
                observer.onNext(objects.map { return $0.compoundKey })
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
            }
            .observeOn(MainScheduler.instance)
            .map(takeFromRealm)
    }

    private func takeFromRealm<T: AutoObject>(identifiers: [String]) -> [T] {
        guard let realm = try? Realm() else {
            return []
        }
        return realm.objects(T.self).toArray() // identifiers.flatMap { realm.object(ofType: T.self, forPrimaryKey: $0) }
    }
}
