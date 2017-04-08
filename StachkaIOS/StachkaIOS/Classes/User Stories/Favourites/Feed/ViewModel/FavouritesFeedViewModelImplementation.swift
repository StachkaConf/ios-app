//
//  FavouritesFeedViewModelImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxCocoa
import RxSwift

class FavouritesFeedViewModelImplementation {
    weak var view: FeedView?
    var disposeBag = DisposeBag()

    init(view: FeedView) {
        self.view = view
        view
            .indexSelected
            .subscribe(onNext: { _ in

            })
            .disposed(by: disposeBag)
    }

    fileprivate var _presentations: Variable<[PresentationSectionModel]> = Variable([])
}

extension FavouritesFeedViewModelImplementation: FavouritesFeedViewModel {
    var presentations: Observable<[PresentationSectionModel]> {
        return _presentations.asObservable()
    }
}

extension FavouritesFeedViewModelImplementation: FavouritesFeedModuleOutput {
    
}
