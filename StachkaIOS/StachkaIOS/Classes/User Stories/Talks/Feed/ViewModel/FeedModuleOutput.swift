//
//  FeedModuleOutput.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxSwift

protocol FeedModuleOutput: ModuleOutput {
    var filterSelected: Observable<Void> { get }
    var presentationSelected: Observable<Presentation> { get }
}
