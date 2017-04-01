//
//  Observable.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 01.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {
    static func createWithError<T>(_ error: Error) -> Observable<T> {
        return Observable<T>.create { observer in
            observer.onError(error)
            return Disposables.create()
        }
    }
}
