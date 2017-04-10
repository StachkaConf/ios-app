//
//  TalksUserStoryAssemblyFactory.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol TalksUserStoryAssemblyFactory {
    func talksFeedAssembly() -> ModuleAssembly
    func talksFiltersMainAssembly() -> ModuleAssembly
    func talksFiltersAssembly() -> FilterAssembly
    func presentationInfoAssembly() -> PresentationInfoAssembly
}
