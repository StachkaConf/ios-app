//
//  UIStoryboard.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 29.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func createControllerFromStoryboardWith<T: UIViewController>(name storyboardName: String) -> T {

        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: T.storyboardId) as? T else {
            fatalError()
        }

        return vc
    }
}
