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
    fileprivate let parentFilter: ParentFilter
    fileprivate weak var view: FiltersView?

    init(view: FiltersView,
         filterService: FilterService,
         filterFactory: FilterFactory,
         filterCellViewModelFactory: FilterCellViewModelFactory,
         parentFilter: ParentFilter) {
        self.view = view
        self.filterService = filterService
        self.filterFactory = filterFactory
        self.filterCellViewModelFactory = filterCellViewModelFactory
        self.parentFilter = parentFilter

        prepareViewModelsForParentFilter()

        view.indexSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.changeFilterSelection(forIndex: indexPath.row)
            })
            .disposed(by: disposeBag)

        view.dissappear
            .subscribe(onCompleted: { [weak self] in
                guard let strongSelf = self else { return }
                let filters: [Filter] = [strongSelf.parentFilter] + strongSelf.parentFilter.childFilters
                let updatedValues = strongSelf._filters.value.map { $0.selected }
                strongSelf.filterService
                    .change(filters, using: updatedValues)
                    .subscribe()
                    .addDisposableTo(strongSelf.disposeBag)
            })
            .disposed(by: disposeBag)
    }

    private func prepareViewModelsForParentFilter()  {
        let allFilters = [parentFilter] + parentFilter.childFilters
        let viewModels = filterCellViewModelFactory.tickViewModels(from: allFilters)
        _filters.value = viewModels
    }

    private func changeFilterSelection(forIndex index: Int) {
        // если у нас родительская модель
        if index == 0 {
            let newValue = !_filters.value[0].selected
            _filters.value = _filters.value.map {
                var newModel = $0
                newModel.selected = newValue
                return newModel
            }
        } else {
            _filters.value[0].selected = false
            _filters.value[index].selected = !_filters.value[index].selected
        }
    }
}
