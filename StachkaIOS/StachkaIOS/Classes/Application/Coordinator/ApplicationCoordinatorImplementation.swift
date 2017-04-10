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

    private weak var window: UIWindow?
    private var tabBarController: UITabBarController
    private var onboardingModuleAssembly: ModuleAssembly
    private var initialUserStoriesCoordinatorsFactory: InitialUserStoriesCoordinatorsFactory

    var childCoordinators: [Coordinator] = []

    private let disposeBag = DisposeBag()

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
        let talksNavigationController = UINavigationController()
        //tabBarController.embed(viewController: talksNavigationController)
        let talksCoordinator = initialUserStoriesCoordinatorsFactory.talksCoordinator(rootNavigationController: talksNavigationController)
        add(coordinator: talksCoordinator)
        talksCoordinator.start()

//        let favouritesNavigationController = UINavigationController()
//        tabBarController.embed(viewController: favouritesNavigationController)
//        let favouritesCoordinator = initialUserStoriesCoordinatorsFactory.favouritesCoordinator(rootNavigationController: favouritesNavigationController)
//        add(coordinator: favouritesCoordinator)
//        favouritesCoordinator.start()

        createDismissOnboarding(andShow: talksNavigationController)
            .subscribe()
            .disposed(by: disposeBag)
    }

    // MARK: Private

    private func createDismissOnboarding(andShow viewController: UIViewController) -> Observable<Void> {
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
                viewController.transitioningDelegate = animator
                onboarding.present(viewController, animated: true, completion: {
                    observer.onCompleted()
                })
            }

            return Disposables.create()
        }
    }
}
