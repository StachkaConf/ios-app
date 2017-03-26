//
//  ConferencesCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import RxSwift

class ConferencesCoordinatorImplementation: ConferencesCoordinator {

    private let rootController: UIViewController
    private let assembly: AssemblyFactory
    private let disposeBag = DisposeBag()

    init(assembly: AssemblyFactory, rootController: UIViewController) {
        self.rootController = rootController
        self.assembly = assembly
    }

    func start() {
        guard let moduleOutputProvider = rootController as? ModuleOutputProvider,
              let output = moduleOutputProvider.moduleOutput as? FeedModuleOutput
            else {
                return
        }

        output.filterSelected
            .subscribe(onNext: {
                print("Router message received")
            })
            .disposed(by: disposeBag)
    }
}
