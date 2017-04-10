//
//  PresentationInfoAssembly.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 10.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

protocol PresentationInfoAssembly {
    func module(withPresentation presentation: Presentation) -> UIViewController
}
