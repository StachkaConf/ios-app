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

    fileprivate var disposeBag = DisposeBag()
    fileprivate var currentFilters = Variable<[Filter]>([])

    fileprivate func shouldLoadNextPage(visiblePage: Int) -> Bool {
        return _presentations.value.count % Constants.pageInterval < visiblePage % Constants.pageInterval
    }

    fileprivate var _presentations: Variable<[PresentationSectionModel]> = Variable([])

    init(view: FeedView,
         filterService: FilterService,
         presentationService: PresentationService,
         searchConfigurationFactory: SearchConfigurationFactory,
         cellViewModelFactory: PresentationCellViewModelFactory) {
        
        self.view = view
        self.filterService = filterService
        self.presentationService = presentationService
        self.searchConfigurationFactory = searchConfigurationFactory
        self.cellViewModelFactory = cellViewModelFactory

        filterService
            .updateFilters([SectionFilter.self])
            .bindTo(currentFilters)
            .disposed(by: disposeBag)

        currentFilters.asObservable()
            .map { [weak self] filters -> PresentationServcieConfiguration in
                guard let strongSelf = self else { return PresentationServcieConfiguration() }
                return strongSelf.searchConfigurationFactory.searchConfiguration(from: filters)
            }
            .flatMap { [weak self] configuration -> Observable<[Presentation]> in
                guard let strongSelf = self else { return Observable.empty() }
                return strongSelf.presentationService.presentations(with: configuration).catchErrorJustReturn([])
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
