//
//  TalksFeedAssembly.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class TalksFeedAssembly: ModuleAssembly {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func module() -> UIViewController {
        let filterService = assemblyFactory.services().filterService()
        let presentationService = assemblyFactory.services().presentationService()
        let searchConfigurationFactory = assemblyFactory.helpers().searchConfigurationFactory()
        let viewController: FeedViewController =
            UIStoryboard.createControllerFromStoryboardWith(name: StoryboardName.talks)
        let viewModel = FeedViewModelImplementation(view: viewController,
                                                    filterService: filterService,
                                                    presentationService: presentationService,
                                                    searchConfigurationFactory: searchConfigurationFactory)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
