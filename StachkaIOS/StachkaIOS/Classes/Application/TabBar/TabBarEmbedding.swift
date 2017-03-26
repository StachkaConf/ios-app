//
//  TabBarEmbeddable.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

protocol TabBarEmbedding {
    func embed(viewController: UIViewController)
}

extension TabBarEmbedding where Self: UITabBarController {
    func embed(viewController: UIViewController) {
        guard viewControllers != nil else {
            viewControllers = [viewController]
            return
        }
        viewControllers?.append(viewController)
    }
}
