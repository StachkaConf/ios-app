//
//  OnboardingAssembly.swift
//  StachkaIOS
//
//  Created by Konstantin Mordan on 02/04/2017.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class OnboardingAssembly: ModuleAssembly {
    func module() -> UIViewController {
        let viewController: OnboardingViewController = UIStoryboard
            .createController(withStoryboardId: StoryboardIdentifier.main)
        
        return viewController
    }
}
