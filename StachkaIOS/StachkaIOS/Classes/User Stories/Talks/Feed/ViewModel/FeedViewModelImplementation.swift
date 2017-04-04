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
    let presentationService: PresentationService
    let filterService: FilterService
    let searchConfigurationFactory: SearchConfigurationFactory
    var disposeBag = DisposeBag()

    init(view: FeedView,
         filterService: FilterService,
         presentationService: PresentationService,
         searchConfigurationFactory: SearchConfigurationFactory) {
        
        self.view = view
        self.filterService = filterService
        self.presentationService = presentationService
        self.searchConfigurationFactory = searchConfigurationFactory

        let firstCellViewModel = PresentationCellViewModel(title: "Ancd")
        let secondCellViewModel = PresentationCellViewModel(title: "Bvcd")
        _presentations.value = [firstCellViewModel, secondCellViewModel]

        filterService
            .updateFilters([SectionFilter.self])
            .map { [weak self] filters -> PresentationServcieConfiguration in
                guard let strongSelf = self else { return PresentationServcieConfiguration() }
                return strongSelf.searchConfigurationFactory.searchConfiguration(from: filters)
            }
            .flatMap { [weak self] configuration -> Observable<[Presentation]> in
                guard let strongSelf = self else { return Observable.just([]) }
                return strongSelf.presentationService.presentations(with: configuration)
            }
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { presentation in
                print("Received")
            })

        view.indexSelected
            .subscribe(onNext: { indexPath in
                print("Selected: \(indexPath)")
            })
            .disposed(by: disposeBag)
        view.indexDisplayed
            .subscribe(onNext: { indexPath in
                print("Displayed: \(indexPath)")
            })
            .disposed(by: disposeBag)
        view.filterSelected
            .subscribe(onNext: {
                print("Filter")
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
