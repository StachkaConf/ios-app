//
//  NetworkClientImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift

enum NetworkClientError: Error {
    case emptyDataReturned
}

class NetworkClientImplementation: NetworkClient {
    private let session: URLSession
    
    // MARK: Конструкторы
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - Методы протокола NetworkClient

    func perform(request: URLRequest) -> Observable<Data> {
        return Observable.create { [weak self] observer in
            guard let strongSelf = self else { return Disposables.create() }
            let dataTask = strongSelf.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                if let data = data {
                    observer.onNext(data)
                }
                observer.onCompleted()
            }
            dataTask.resume()

            return Disposables.create()
        }
    }
}
