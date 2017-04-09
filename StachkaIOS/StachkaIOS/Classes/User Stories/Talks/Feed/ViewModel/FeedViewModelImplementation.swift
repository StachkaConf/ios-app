//
//  FeedViewModelImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FeedViewModelImplementation {

    enum Constants {
        static let pageInterval = 20
    }

    weak var view: FeedView?

    fileprivate let presentationService: PresentationService
    fileprivate let filterService: FilterService
    fileprivate let searchConfigurationFactory: SearchConfigurationFactory
    fileprivate let cellViewModelFactory: PresentationCellViewModelFactory
    fileprivate let filterFactory: FilterFactory

    fileprivate var disposeBag = DisposeBag()
    fileprivate var currentFilters = Variable<[Filter]>([])

    fileprivate var _presentations: Variable<[PresentationSectionModel]> = Variable([])

    init(view: FeedView,
         filterService: FilterService,
         presentationService: PresentationService,
         filterFactory: FilterFactory,
         searchConfigurationFactory: SearchConfigurationFactory,
         cellViewModelFactory: PresentationCellViewModelFactory) {
        
        self.view = view
        self.filterService = filterService
        self.presentationService = presentationService
        self.searchConfigurationFactory = searchConfigurationFactory
        self.cellViewModelFactory = cellViewModelFactory
        self.filterFactory = filterFactory
        
        filterService
            .updateFilters()
            .do(onNext: { [weak self] filters in
                guard let strongSelf = self else { return }
                if filters.count == 0 {
                    let filters = strongSelf.filterFactory.createFilters()
                    strongSelf.filterService.saveNew(filters).subscribe().addDisposableTo(strongSelf.disposeBag)
                    return
                }
            })
            .bindTo(currentFilters)
            .disposed(by: disposeBag)

        presentationService
            .updatePresentationsAndSave()
            .subscribe()
            .disposed(by: disposeBag)

        Observable<[Filter]>.combineLatest(presentationService.presentationsUpdated(),
                                           currentFilters.asObservable()) { _, filters in
                return filters
            }
            .flatMap { [weak self] filters in
                return self?.presentationService.filteredPresentations(with: filters) ?? Observable.empty()
            }
            .map { [weak self] presentations in
                return self?.cellViewModelFactory.sections(from: presentations) ?? []
            }
            .bindTo(_presentations)
            .disposed(by: disposeBag)

        view.indexSelected
            .subscribe(onNext: { indexPath in
                print("Selected: \(indexPath)")
            })
            .disposed(by: disposeBag)

        view.filterSelected
            .subscribe(onNext: {
                print("Filter")
            })
            .disposed(by: disposeBag)
    }
}

extension FeedViewModelImplementation: FeedViewModel {
    var presentations: Observable<[PresentationSectionModel]> {
        return _presentations.asObservable()
    }
}

extension FeedViewModelImplementation: FeedModuleOutput, CoordinatorConfigurable {
    var filterSelected: Observable<Void> {
        return view?.filterSelected ?? Observable.empty()
    }

    func configure(withCoordinator coordinator: Coordinator) {
        guard let coordinator = coordinator as? TalksCoordinatorOutput else {
            return
        }
        coordinator
            .filtersChanged
            .subscribe(onNext: { filter in
                print("Filters changed")
            })
            .disposed(by: disposeBag)
    }
}
