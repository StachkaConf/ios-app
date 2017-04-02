//
//  UserStoryAssembly.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

protocol UserStoryAssembly: Assembly {
    // TODO: Растащить по разным ассембли
    func conferencesFeedModule() -> UIViewController
    func conferencesDetailModule() -> UIViewController
    func conferencesFilterModule() -> UIViewController
}
