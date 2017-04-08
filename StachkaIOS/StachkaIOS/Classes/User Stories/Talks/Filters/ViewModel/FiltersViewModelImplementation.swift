//
//  FiltersViewModelImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxSwift
import RealmSwift

class FiltersViewModelImplementation: FiltersViewModel {
    var filters: Observable<[FilterCellViewModel]> {
        return _filters.asObservable()
    }
    var _filters: Variable<[FilterCellViewModel]> = Variable([])
    let disposeBag = DisposeBag()

    fileprivate let filterFactory: FilterFactory
    fileprivate let filterCellViewModelFactory: FilterCellViewModelFactory
    fileprivate let filterService: FilterService
    fileprivate weak var view: FiltersView?

    init(view: FiltersView,
         filterService: FilterService,
         filterFactory: FilterFactory,
         filterCellViewModelFactory: FilterCellViewModelFactory) {
        self.view = view
        self.filterService = filterService
        self.filterFactory = filterFactory
        self.filterCellViewModelFactory = filterCellViewModelFactory

        let types: [Object.Type] = [SectionFilter.self]
        filterService
            .updateFilters(types)
            .map { [weak self] filters -> [FilterCellViewModel] in
                guard let strongSelf = self else { return [] }
                return strongSelf.filterCellViewModelFactory.viewModels(from: filters)
            }
            .subscribe(onNext: { [weak self] filterModels in
                guard let strongSelf = self else { return }
                strongSelf._filters.value = filterModels
            })
            .disposed(by: disposeBag)

        view.indexSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard var viewModel = self?._filters.value[indexPath.row] as? SectionFilterCellViewModel else {
                    return
                }
                viewModel.selected = !viewModel.selected
                self?._filters.value[indexPath.row] = viewModel
            })
            .disposed(by: disposeBag)

        view.dissappear
            .subscribe(onCompleted: { [weak self] in
                guard let strongSelf = self else { return }
                let filterViewModels = strongSelf._filters.value
                let filters = strongSelf.filterCellViewModelFactory.filters(from: filterViewModels)
                strongSelf.filterService.deleteAndSave(filters).subscribe().addDisposableTo(strongSelf.disposeBag)
            })
            .disposed(by: disposeBag)
    }
}
