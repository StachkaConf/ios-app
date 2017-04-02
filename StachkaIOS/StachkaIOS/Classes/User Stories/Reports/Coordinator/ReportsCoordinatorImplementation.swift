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

    private let rootController: UIViewController
    private let assembly: AssemblyFactory
    private let disposeBag = DisposeBag()
    private var filters = PublishSubject<[Filter]>()

    init(assembly: AssemblyFactory, rootController: UIViewController) {
        self.rootController = rootController
        self.assembly = assembly
    }

    func start() {
        guard let moduleOutputProvider = rootController as? ModuleOutputProvider,
              let configurableOutput = moduleOutputProvider.moduleOutput as? FeedModuleOutput & CoordinatorConfigurable
            else {
                return
        }

        configurableOutput
            .filterSelected
            .subscribe(onNext: { [weak self] in
                self?.openFilters()
            })
            .disposed(by: disposeBag)

        configurableOutput.configure(withCoordinator: self)
    }

    private func openFilters() {
        let filtersModule = assembly.userStories().conferencesFilterModule()
        rootController.navigationController?.pushViewController(filtersModule, animated: true)
    }

    // MARK: ReportsCoordinatorOutput

    var filtersChanged: Observable<[Filter]> {
        return filters.asObservable()
    }
}

