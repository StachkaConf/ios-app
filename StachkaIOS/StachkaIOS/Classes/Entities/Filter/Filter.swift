//
//  Filter.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol Filter: class {
    var selected: Bool { get set }
    var title: String { get set }

    func query() -> String
}

extension Filter {
    func query() -> String {
        return ""
    }
}
