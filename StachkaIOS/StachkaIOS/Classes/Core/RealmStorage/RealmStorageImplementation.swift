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
    func save<T: AutoObject>(_ objects: [T]) -> Observable<Void> {
        return Observable.create { observer in
            guard let backgroundRealm = try? Realm() else {
                observer.onCompleted()
                return Disposables.create()
            }
            do {
                try backgroundRealm.write {
                    backgroundRealm.add(objects)
                }
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
            }
            .observeOn(MainScheduler.instance)
    }

    func replaceAll<T: AutoObject>(_ objects: [T]) -> Observable<Void> {
        return Observable.create { observer in
            guard let backgroundRealm = try? Realm() else {
                observer.onCompleted()
                return Disposables.create()
            }
            do {
                try backgroundRealm.write {
                    let oldObjects = backgroundRealm.objects(T.self)
                    for object in oldObjects {
                        for element in object.provideRelationships() {
                            backgroundRealm.delete(element)
                        }
                    }

                    backgroundRealm.delete(oldObjects)
                    backgroundRealm.add(objects)
                }
                
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
            }
            .observeOn(MainScheduler.instance)
    }
}
