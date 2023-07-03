//
//  MenuRouter.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 25.06.2023.
//

import UIKit

protocol MenuRouterLogic: AnyObject {
    func navigateToDetails()
}

class MenuRouter {
    weak var viewController: UIViewController?
}

extension MenuRouter: MenuRouterLogic {
    func navigateToDetails() {
//        viewController?.navigationController?.pushViewController(<#T##UIViewController#>, animated: <#T##Bool#>)
    }
}
