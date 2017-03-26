//
//  FeedViewModelImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift

class FeedViewModelImplementation {
    weak var view: FeedView?
    var disposeBag = DisposeBag()

    init(view: FeedView) {
        self.view = view
        let firstCellViewModel = PresentationCellViewModel(title: "Ancd")
        let secondCellViewModel = PresentationCellViewModel(title: "Bvcd")
        _presentations.value = [firstCellViewModel, secondCellViewModel]

        view
            .indexSelected
            .subscribe(onNext: { _ in

            })
            .disposed(by: disposeBag)
    }

    fileprivate var _presentations: Variable<[PresentationCellViewModel]> = Variable([])
}

extension FeedViewModelImplementation: FeedViewModel {
    var presentations: Observable<[PresentationCellViewModel]> {
        return _presentations.asObservable()
    }

}
