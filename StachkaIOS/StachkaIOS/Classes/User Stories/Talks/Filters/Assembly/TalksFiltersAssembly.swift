//
//  TalksFiltersAssembly.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class TalksFiltersAssembly: ModuleAssembly {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func module() -> UIViewController {
        let filterService = assemblyFactory.services().filterService()
        let filterFactory = assemblyFactory.helpers().filterFactory()
        let filterCellViewModelFactory = FilterCellViewModelFactoryImplementation()
        let viewController: FiltersViewController =
            UIStoryboard.createControllerFromStoryboardWith(name: StoryboardName.talks)
        let viewModel = FiltersViewModelImplementation(view: viewController,
                                                       filterService: filterService,
                                                       filterFactory: filterFactory,
                                                       filterCellViewModelFactory: filterCellViewModelFactory)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
