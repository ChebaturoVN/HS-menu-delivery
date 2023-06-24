//
//  TabBarController.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 23.06.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        tabBar.barTintColor = UIColor.tabBarBackground
        tabBar.tintColor = UIColor.tabBarSelect
        tabBar.backgroundColor = UIColor.tabBarBackground
        tabBar.clipsToBounds = true
        tabBar.frame.size.height = 83
        tabBar.barStyle = .default
    }
}
