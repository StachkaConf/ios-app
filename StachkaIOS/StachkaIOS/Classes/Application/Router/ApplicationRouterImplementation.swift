//
//  ApplicationRouterImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class ApplicationRouterImplementation: ApplicationRouter {
    private weak var window: UIWindow?
    private var tabBarEmbedding: TabBarEmbedding

    init(window: UIWindow, tabBarEmbedding: TabBarEmbedding) {
        self.window = window
        self.tabBarEmbedding = tabBarEmbedding
    }
}
