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
        static let animatorConfiguration = RectangleDissolveAnimatorConfiguration(rectanglesVertical: 14, rectanglesHorizontal: 8, batchSize: 10, fadeAnimationDuration: 0.5, tempo: 1000.0)
    }

    var childCoordinators: [Coordinator] = []
    let assembly: AssemblyFactory
    weak var window: UIWindow?
    var tabBarController: UITabBarController?

    let disposeBag = DisposeBag()

    init(assembly: AssemblyFactory, window: UIWindow?) {
        self.assembly = assembly
        self.window = window
    }

    func start() {
        tabBarController = assembly.userStories().tabBar()
        let feed = assembly.userStories().conferencesFeedModule()
        embedInTabBarWithNavigationController(controller: feed)
        let conferencesCoordinator = assembly.coordinators().conferencesCoordinator(rootController: feed)
        add(coordinator: conferencesCoordinator)

        let favourites = assembly.userStories().favouritesFeedModule()
        embedInTabBarWithNavigationController(controller: favourites)
        let favouritesCoordinator = assembly.coordinators().favouritesCoordinator(rootController: favourites)
        add(coordinator: favouritesCoordinator)

        createDismissOnboardingAndShowTabBar()
            .subscribe(onCompleted: {
                conferencesCoordinator.start()
                favouritesCoordinator.start()
            })
            .disposed(by: disposeBag)
    }

    // MARK: Private

    private func embedInTabBarWithNavigationController(controller: UIViewController) {
        let navigationController = UINavigationController(rootViewController: controller)
        tabBarController?.embed(viewController: navigationController)
    }

    private func createDismissOnboardingAndShowTabBar() -> Observable<Void> {

        return Observable.create { [weak self] observer in
            guard let strongSelf = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            let onboarding = strongSelf.assembly.userStories().onboardingModule()
            let animator = RectangleDissolveAnimator(configuration: Constants.animatorConfiguration)

            strongSelf.window?.rootViewController = onboarding
            strongSelf.window?.makeKeyAndVisible()

            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDelay) {
                guard let tabBarController = strongSelf.tabBarController else {
                    return
                }
                tabBarController.transitioningDelegate = animator
                onboarding.present(tabBarController, animated: true, completion: {
                    observer.onCompleted()
                })
            }

            return Disposables.create()
        }
    }
}
