//
//  FiltersViewModelImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxSwift

class FiltersViewModelImplementation: FiltersViewModel {
    var filters: Observable<[FilterCellViewModel]> {
        return _filters.asObservable()
    }
    var _filters: Variable<[FilterCellViewModel]> = Variable([])

    weak var view: FiltersView?

    init(view: FiltersView) {
        self.view = view
    }
}
