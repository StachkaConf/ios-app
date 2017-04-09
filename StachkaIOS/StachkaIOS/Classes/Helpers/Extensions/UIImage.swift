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

        static var chevron: UIImage {
            return UIImage(named: "chevron")!
        }
    }

    enum Categories {
        static var development: UIImage {
            return UIImage(named: "development")!
        }

        static var education: UIImage {
            return UIImage(named: "education")!
        }

        static var business: UIImage {
            return UIImage(named: "business")!
        }

        static var marketing: UIImage {
            return UIImage(named: "marketing")!
        }
    }

    static var placeholder: UIImage {
        return UIImage(named: "nophoto")!
    }
}
