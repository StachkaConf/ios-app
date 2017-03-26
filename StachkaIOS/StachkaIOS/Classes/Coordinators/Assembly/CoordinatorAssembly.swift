//
//  CoordinatorAssembly.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorAssembly {
    func applicationCoordinator(window: UIWindow) -> ApplicationCoordinator
}
