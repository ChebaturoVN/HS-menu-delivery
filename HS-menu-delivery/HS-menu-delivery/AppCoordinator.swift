//
//  AppCoordinator.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import UIKit

final class AppCoordinator {

    private var navigationController: UINavigationController?
    private let tabCoordinator: TabBarCoordinator

    init() {
        tabCoordinator = TabBarCoordinator()
    }

    func start() -> UIViewController {
//        let navController = UINavigationController()
//        navController.navigationBar.backIndicatorImage = .back
//        navController.navigationBar.backIndicatorTransitionMaskImage = .back
//        let viewController = ViewController()
//        navController.setViewControllers([viewController], animated: true)
//        navigationController = navController
        return showTabBar()
    }

    func showTabBar() -> UITabBarController {
        let controller = tabCoordinator.start()
        return controller
    }

}
