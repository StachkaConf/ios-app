//
//  FiltersViewModelImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxSwift
import RealmSwift

class FiltersMainViewModelImplementation: FiltersMainViewModel {
    var filters: Observable<[FilterCellViewModel]> {
        return _filters.asObservable()
    }
    var _filters: Variable<[FilterCellViewModel]> = Variable([])
    var parentFilters: [ParentFilter] = []
    var parentFilterPublisher = PublishSubject<ParentFilter>()

    let disposeBag = DisposeBag()

    fileprivate let filterFactory: FilterFactory
    fileprivate let filterCellViewModelFactory: FilterCellViewModelFactory
    fileprivate let filterService: FilterService
    fileprivate weak var view: FiltersMainView?

    init(view: FiltersMainView,
         filterService: FilterService,
         filterFactory: FilterFactory,
         filterCellViewModelFactory: FilterCellViewModelFactory) {
        self.view = view
        self.filterService = filterService
        self.filterFactory = filterFactory
        self.filterCellViewModelFactory = filterCellViewModelFactory

        let types: [Object.Type] = [AllPlacesFilter.self, CategoryFilter.self]
        filterService
            .updateFilters(types)
            .do(onNext: { [weak self] filters in
                guard let strongSelf = self else { return }
                strongSelf.parentFilters = filters as? [ParentFilter] ?? []
            })
            .map { [weak self] filters -> [FilterCellViewModel] in
                guard let strongSelf = self else { return [] }
                return strongSelf.filterCellViewModelFactory.navigationViewModels(from: filters)
            }
            .subscribe(onNext: { [weak self] filterModels in
                guard let strongSelf = self else { return }
                strongSelf._filters.value = filterModels
            })
            .disposed(by: disposeBag)

        view.indexSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let strongSelf = self else { return }
                strongSelf.parentFilterPublisher.onNext(strongSelf.parentFilters[indexPath.row])
            })
            .disposed(by: disposeBag)
    }
}

extension FiltersMainViewModelImplementation: FiltersMainModuleOutput {
    var parentFilterSelected: Observable<ParentFilter> {
        return parentFilterPublisher.asObservable()
    }
}
