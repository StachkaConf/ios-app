//
//  UIViewController.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

extension UIViewController {
    static var storyboardId: String {
        return String(describing: self)
    }
}

