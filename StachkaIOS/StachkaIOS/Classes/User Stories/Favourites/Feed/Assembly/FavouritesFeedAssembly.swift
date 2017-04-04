//
//  FavouritesFeedAssembly.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class FavouritesFeedAssembly: ModuleAssembly {

    let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }

    func module() -> UIViewController {
        let viewController: FeedViewController = UIStoryboard.createControllerFromStoryboardWith(name: StoryboardName.talks)
        let viewModel = FavouritesFeedViewModelImplementation(view: viewController)
        viewController.viewModel = viewModel
        // FIXME: это заглушка, чтобы проверить работу табов
        viewController.view.backgroundColor = UIColor.red
        
        return viewController
    }
}
