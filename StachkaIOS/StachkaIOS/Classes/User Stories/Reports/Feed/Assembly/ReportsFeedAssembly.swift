//
//  ReportsFeedAssembly.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit
class ReportsFeedAssembly: ModuleAssembly {
    func module() -> UIViewController {
        let assemblyFactory = AssemblyFactoryImplementation()
        
        let filterService = assemblyFactory.services().filterService()
        let presentationService = assemblyFactory.services().presentationService()
        let searchConfigurationFactory = assemblyFactory.helpers().searchConfigurationFactory()
        let viewController: FeedViewController =
            UIStoryboard.createControllerFromStoryboardWith(name: StoryboardName.reports)
        let viewModel = FeedViewModelImplementation(view: viewController,
                                                    filterService: filterService,
                                                    presentationService: presentationService,
                                                    searchConfigurationFactory: searchConfigurationFactory)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
