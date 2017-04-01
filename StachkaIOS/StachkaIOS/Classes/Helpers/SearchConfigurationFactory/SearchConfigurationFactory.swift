//
//  SearchConfigurationFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 01.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol SearchConfigurationFactory {
    func searchConfiguration(from: [Filter]) -> PresentationServcieConfiguration
}
