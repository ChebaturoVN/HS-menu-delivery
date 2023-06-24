//
//  AppDelegate.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }
}
