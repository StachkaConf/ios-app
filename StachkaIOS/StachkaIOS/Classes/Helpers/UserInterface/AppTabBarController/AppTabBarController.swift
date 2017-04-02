//
//  TabBarController.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

enum TabBarConstants {
    static let imageInsets = UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0)
}

class AppTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
    }
}
