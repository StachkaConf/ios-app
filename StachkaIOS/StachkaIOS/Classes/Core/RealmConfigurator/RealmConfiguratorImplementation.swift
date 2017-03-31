//
//  RealmConfiguratorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 31.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfiguratorImplementation: RealmConfigurator {
    func configure() {
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
    }
}
