//
//  ApplicationCoordinatorImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 25.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import RectangleDissolve
import RxSwift
import RxCocoa

class ApplicationCoordinatorImplementation: ApplicationCoordinator, CoordinatorWithDependencies {

    enum Constants {
        static let animationDelay = 1.0
        static let animatorConfiguration = RectangleDissolveAnimatorConfiguration(rectanglesVertical: 14,
                                                                                  rectanglesHorizontal: 8,
                                                                                  batchSize: 10,
                                                                                  fadeAnimationDuration: 0.5,
                                                                                  tempo: 1000.0)
    }

    weak var window: UIWindow?
    var tabBarController: UITabBarController
    var onboardingModuleAssembly: ModuleAssembly
    var initialUserStoriesCoordinatorsFactory: InitialUserStoriesCoordinatorsFactory

    var childCoordinators: [Coordinator] = []

    let disposeBag = DisposeBag()

    init(window: UIWindow?,
         rootTabBarController: UITabBarController,
         onboardingModuleAssembly: ModuleAssembly,
         initialUserStoriesCoordinatorsFactory: InitialUserStoriesCoordinatorsFactory) {
        self.window = window
        self.tabBarController = rootTabBarController
        self.onboardingModuleAssembly = onboardingModuleAssembly
        self.initialUserStoriesCoordinatorsFactory = initialUserStoriesCoordinatorsFactory
    }

    func start() {
        let reportsCoordinator = initialUserStoriesCoordinatorsFactory.reportsCoordinator(rootTabBarController: tabBarController)
        add(coordinator: reportsCoordinator)

        let favouritesCoordinator = initialUserStoriesCoordinatorsFactory.favouritesCoordinator(rootTabBarController: tabBarController)
        add(coordinator: favouritesCoordinator)

        createDismissOnboardingAndShowTabBar()
            .subscribe(onCompleted: {
                reportsCoordinator.start()
                favouritesCoordinator.start()
            })
            .disposed(by: disposeBag)
    }

    // MARK: Private

    private func createDismissOnboardingAndShowTabBar() -> Observable<Void> {

        return Observable.create { [weak self] observer in
            guard let strongSelf = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            let onboarding = strongSelf.onboardingModuleAssembly.module()
            let animator = RectangleDissolveAnimator(configuration: Constants.animatorConfiguration)

            strongSelf.window?.rootViewController = onboarding
            strongSelf.window?.makeKeyAndVisible()

            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDelay) {
                strongSelf.tabBarController.transitioningDelegate = animator
                onboarding.present(strongSelf.tabBarController, animated: true, completion: {
                    observer.onCompleted()
                })
            }

            return Disposables.create()
        }
    }
}
