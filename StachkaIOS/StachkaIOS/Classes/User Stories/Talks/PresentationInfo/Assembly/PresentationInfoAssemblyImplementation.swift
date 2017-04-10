//
//  PresentationInfoAssemblyImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 10.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class PresentationInfoAssemblyImplementation: PresentationInfoAssembly {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func module(withPresentation presentation: Presentation) -> UIViewController {
        let dateFormatter = assemblyFactory.helpers().dateFormatter()
        let cellViewModelFactory = PresentationInfoCellViewModelFactoryImplementation(dateFormatter: dateFormatter)
        let viewController: PresentationInfoViewController =
            UIStoryboard.createControllerFromStoryboardWith(name: StoryboardName.talks)
        let viewModel = PresentationInfoViewModelImplementation(view: viewController,
                                                                presentation: presentation,
                                                                presentationViewModelFactory: cellViewModelFactory)
        viewController.viewModel = viewModel

        return viewController
    }
}
