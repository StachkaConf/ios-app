//
//  AppDelegate.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else {
            return true
        }
        
        let assemblyFactory = AssemblyFactoryImplementation()
        assemblyFactory.core().realmConfigurator().configure()
        
        let appCoordinatorFactory = assemblyFactory.coordinators().applicationCoordinatorFactory()
        coordinator = appCoordinatorFactory.applicationCoordinator(window: window)
        coordinator?.start()

        return true
    }
}

