//
//  ApplicationCoordinatorFactory.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 01/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

protocol ApplicationCoordinatorFactory {
    func applicationCoordinator(window: UIWindow) -> ApplicationCoordinator
}
