//
//  ReportsCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import RxSwift

class ReportsCoordinatorImplementation: ReportsCoordinator {

    private let rootTabBarController: UITabBarController
    private let reportsUserStoryAssembliesFactory: ReportsUserStoryAssembliesFactory
    
    private let disposeBag = DisposeBag()
    private var filters = PublishSubject<[Filter]>()

    private var reportsUserStoryRootController: UIViewController?
    
    init(rootTabBarController: UITabBarController,
         reportsUserStoryAssembliesFactory: ReportsUserStoryAssembliesFactory) {
        self.rootTabBarController = rootTabBarController
        self.reportsUserStoryAssembliesFactory = reportsUserStoryAssembliesFactory
    }

    func start() {
        reportsUserStoryRootController = reportsUserStoryAssembliesFactory.reportsFeedAssembly().module()
        
        guard let userStoryRootController = self.reportsUserStoryRootController else {
            return
        }
        
        let nc = UINavigationController(rootViewController: userStoryRootController)
        rootTabBarController.embed(viewController: nc)
        
        guard let moduleOutputProvider = userStoryRootController as? ModuleOutputProvider
            else {
                return
        }
        
        guard let configurableOutput = moduleOutputProvider.moduleOutput as? FeedModuleOutput else {
            return
        }

        configurableOutput
            .filterSelected
            .subscribe(onNext: { [weak self] in
                self?.openFilters()
            })
            .disposed(by: disposeBag)

        guard let df = configurableOutput as? CoordinatorConfigurable else {
            return
        }
        
        df.configure(withCoordinator: self)
    }
    
    // MARK: ReportsCoordinatorOutput
    
    var filtersChanged: Observable<[Filter]> {
        return filters.asObservable()
    }
    
    // MARK: - Вспомогательные методы
 
    private func openFilters() {
        let filtersModule = reportsUserStoryAssembliesFactory.reportsFiltersAssembly().module()
        reportsUserStoryRootController?.navigationController?.pushViewController(filtersModule, animated: true)
    }
}

