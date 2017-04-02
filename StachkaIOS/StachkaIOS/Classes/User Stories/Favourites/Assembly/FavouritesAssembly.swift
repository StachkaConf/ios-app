//
//  FavouritesAssembly.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class FavouritesAssembly: ModuleAssembly {
    func module() -> UIViewController {
        let storyboardId = StoryboardIdentifier.conferences
        let storyboard = UIStoryboard(name: storyboardId, bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! FeedViewController
        let viewModel = FavouritesFeedViewModelImplementation(view: viewController)
        viewController.viewModel = viewModel
        // FIXME: это заглушка, чтобы проверить работу табов
        viewController.view.backgroundColor = UIColor.red
        
        return viewController
    }
}
