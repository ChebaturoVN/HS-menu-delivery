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
        return showTabBar()
    }

    func showTabBar() -> UITabBarController {
        let controller = tabCoordinator.start()
        return controller
    }

}
