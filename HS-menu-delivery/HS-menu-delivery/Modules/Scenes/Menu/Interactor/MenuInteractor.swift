//
//  MenuInteractor.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import Foundation

protocol MenuInteractorLogic {
    func featchArticle()
}

class MenuInteractor {

    // MARK: - External vars
    var presenter: MenuPresenterLogic?
}

// MARK: - Business logic
extension MenuInteractor: MenuInteractorLogic {
    func featchArticle() {
        presenter?.presentData()
    }
}
