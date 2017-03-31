//
//  CoreAssembly.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol CoreAssembly: Assembly {
    func realmConfigurator() -> RealmConfigurator
}
