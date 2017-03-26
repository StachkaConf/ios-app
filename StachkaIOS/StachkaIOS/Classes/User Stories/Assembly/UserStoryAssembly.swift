//
//  UserStoryAssembly.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

protocol UserStoryAssembly: Assembly {
    func tabBar() -> UITabBarController
    func feedModule() -> UIViewController
    func detailModule() -> UIViewController
    func filterModule() -> UIViewController
}
