//
//  UIImage.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

extension UIImage {
    enum TabBar {
        static var star: UIImage {
            return UIImage(named: "star")!
        }

        static var calendar: UIImage {
            return UIImage(named: "calendar")!
        }
    }

    enum Filters {
        static var checkmark: UIImage {
            return UIImage(named: "checkmark")!
        }
    }
}
