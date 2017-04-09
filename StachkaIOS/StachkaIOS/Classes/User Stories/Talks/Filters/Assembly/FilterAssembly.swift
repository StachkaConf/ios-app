//
//  FilterAssembly.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 09.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

protocol FilterAssembly {
    func module(withParentFilter parentFilter: ParentFilter) -> UIViewController
}
