//
//  RealmStorage.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 07.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxSwift
import Foundation

protocol RealmStorage {
    func save<T: AutoObject>(_ objects: [T]) -> Observable<Void>
    func replaceAll<T: AutoObject>(_ objects: [T]) -> Observable<Void>
}
