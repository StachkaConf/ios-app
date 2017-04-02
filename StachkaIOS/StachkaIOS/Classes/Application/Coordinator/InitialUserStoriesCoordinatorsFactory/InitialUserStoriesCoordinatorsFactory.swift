//
//  InitialUserStoriesCoordinatorsFactory.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 01/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

protocol InitialUserStoriesCoordinatorsFactory {
    func reportsCoordinator(rootTabBarController: UITabBarController) -> ReportsCoordinator
    func favouritesCoordinator(rootTabBarController: UITabBarController) -> FavouritesCoordinator
}
