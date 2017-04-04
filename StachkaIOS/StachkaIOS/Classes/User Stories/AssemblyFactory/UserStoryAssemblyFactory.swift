//
//  UserStoryAssemblyFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 04.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol UserStoryAssemblyFactory {
    func talksAssemblyFactory() -> TalksUserStoryAssemblyFactory
    func favouritesAssemblyFactory() -> FavouritesAssemblyFactory
    func onboardingAssembly() -> OnboardingAssembly
}
