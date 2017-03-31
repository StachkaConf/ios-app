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
    let disposeBag = DisposeBag()

    let filterService: FilterService
    weak var view: FiltersView?

    init(view: FiltersView, filterService: FilterService) {
        self.view = view
        self.filterService = filterService
        let filters = [SectionFilterCellViewModel(sectionName: "Abcd"),  SectionFilterCellViewModel(sectionName: "Bcde")]

        _filters.value = filters

        view.indexSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard var viewModel = self?._filters.value[indexPath.row] as? SectionFilterCellViewModel else {
                    return
                }
                viewModel.selected = !viewModel.selected
                self?._filters.value[indexPath.row] = viewModel
            })
            .disposed(by: disposeBag)
    }
}
