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
    // TODO: Растащить по разным ассембли
    func onboardingModule() -> UIViewController
    func conferencesFeedModule() -> UIViewController
    func conferencesDetailModule() -> UIViewController
    func conferencesFilterModule() -> UIViewController
    func favouritesFeedModule() -> UIViewController
}
