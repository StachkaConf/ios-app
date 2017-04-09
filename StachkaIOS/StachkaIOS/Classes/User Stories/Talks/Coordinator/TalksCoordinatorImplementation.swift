//
//  talksCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import RxSwift

class TalksCoordinatorImplementation: TalksCoordinator {

    private let rootNavigationController: UINavigationController
    private let talksUserStoryAssemblyFactory: TalksUserStoryAssemblyFactory
    
    private let disposeBag = DisposeBag()
    private var filters = PublishSubject<[Filter]>()

    init(rootNavigationController: UINavigationController,
         talksUserStoryAssemblyFactory: TalksUserStoryAssemblyFactory) {
        self.rootNavigationController = rootNavigationController
        self.talksUserStoryAssemblyFactory = talksUserStoryAssemblyFactory
    }

    func start() {
        let feedViewController = talksUserStoryAssemblyFactory.talksFeedAssembly().module()
        rootNavigationController.setViewControllers([feedViewController], animated: false)

        guard let moduleOutputProvider = feedViewController as? ModuleOutputProvider,
              let feedModuleOutput = moduleOutputProvider.moduleOutput as? FeedModuleOutput else {
            return
        }

        feedModuleOutput
            .filterSelected
            .subscribe(onNext: { [weak self] in
                self?.openFilters()
            })
            .disposed(by: disposeBag)

        if let configurableOutput = feedModuleOutput as? CoordinatorConfigurable {
            configurableOutput.configure(withCoordinator: self)
        }
    }
    
    // MARK: - TalksCoordinatorOutput
    
    var filtersChanged: Observable<[Filter]> {
        return filters.asObservable()
    }
    
    // MARK: - Вспомогательные методы
 
    private func openFilters() {
        let filtersModule = talksUserStoryAssemblyFactory.talksFiltersMainAssembly().module()
        rootNavigationController.pushViewController(filtersModule, animated: true)

        guard let moduleOutputProvider = filtersModule as? ModuleOutputProvider,
              let moduleOutput = moduleOutputProvider.moduleOutput as? FiltersMainModuleOutput else {
                return
        }
        moduleOutput
            .parentFilterSelected
            .subscribe(onNext: { [weak self] parentFilter in
                self?.openDetailFilters(withParentFilter: parentFilter)
            })
            .disposed(by: disposeBag)
    }

    private func openDetailFilters(withParentFilter parentFilter: ParentFilter) {
        let filtersDetailModule = talksUserStoryAssemblyFactory.talksFiltersAssembly().module(withParentFilter: parentFilter)
        rootNavigationController.pushViewController(filtersDetailModule, animated: true)
    }
}

