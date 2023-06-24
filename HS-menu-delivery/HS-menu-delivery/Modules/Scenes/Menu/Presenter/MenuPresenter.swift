//
//  MenuPresenter.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import Foundation

protocol MenuPresenterLogic {
    func presentData()

}

class MenuPresenter {

    weak var viewController: MenuDisplayLogic?
}

// MARK - Presentation logic

extension MenuPresenter: MenuPresenterLogic {
    func presentData() {
        
    }
}
