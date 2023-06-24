//
//  TabBarCoordinator.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 23.06.2023.
//

import UIKit

final class TabBarCoordinator {

    private let menuViewController: MenuViewController
    private let menuNavController: UINavigationController

    private let contactsNavController: UINavigationController

    private let profileNavController: UINavigationController

    private let cartNavController: UINavigationController

    private let tabBarController: TabBarController

    init() {
        menuViewController = MenuViewController()
        menuNavController = menuViewController.start()

        contactsNavController = UINavigationController()
        profileNavController = UINavigationController()
        cartNavController = UINavigationController()

        tabBarController = TabBarController()
    }

    @discardableResult
    func start() -> UITabBarController {
        setTabControllers(for: (tabBarController as? TabBarController)!)
        return tabBarController
    }

    private func setTabControllers(for tabBarController: TabBarController) {

        menuNavController.tabBarItem = UITabBarItem(
            title: TabItem.menuTI.title,
            image: TabItem.menuTI.icon?.withRenderingMode(.alwaysOriginal),
            selectedImage: TabItem.menuTI.iconSelected?.withRenderingMode(.alwaysOriginal)
        )
        menuNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: -5, bottom: -8, right: -5)
        contactsNavController.tabBarItem = UITabBarItem(
            title: TabItem.contactsTI.title,
            image: TabItem.contactsTI.icon?.withRenderingMode(.alwaysOriginal),
            selectedImage: TabItem.contactsTI.iconSelected?.withRenderingMode(.alwaysOriginal)
        )
        contactsNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: -5, bottom: -8, right: -5)
        profileNavController.tabBarItem = UITabBarItem(
            title: TabItem.profileTI.title,
            image: TabItem.profileTI.icon?.withRenderingMode(.alwaysOriginal),
            selectedImage: TabItem.profileTI.iconSelected?.withRenderingMode(.alwaysOriginal)
        )
        profileNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: -5, bottom: -8, right: -5)
        cartNavController.tabBarItem = UITabBarItem(
            title: TabItem.cartTI.title,
            image: TabItem.cartTI.icon?.withRenderingMode(.alwaysOriginal),
            selectedImage: TabItem.cartTI.iconSelected?.withRenderingMode(.alwaysOriginal)
        )
        cartNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: -5, bottom: -8, right: -5)
        tabBarController.viewControllers = [
            menuNavController,
            contactsNavController,
            profileNavController,
            cartNavController
        ]
    }
}
