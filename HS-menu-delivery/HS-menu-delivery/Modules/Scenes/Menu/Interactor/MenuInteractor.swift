//
//  MenuInteractor.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import Foundation

protocol MenuInteractorLogic {
    func downloadMenu()
}

class MenuInteractor {

    // MARK: - External vars
    var presenter: MenuPresenterLogic?
}

// MARK: - Business logic
extension MenuInteractor: MenuInteractorLogic {
    func downloadMenu() {
        var productResponse = [MenuCellModel]()
        productResponse.append(.init(
            productUrl: "https://feo.fidele-food.ru/wp-content/uploads/2023/01/panchetta-2.webp",
            title: "Пицца «Панчетта»",
            description: "Сытная пицца на томатном соусе с запеченными колбасками Пепперони, Краковской колбасой, ветчиной и беконом, зеленым луком и моцареллой",
            price: "505")
        )
        productResponse.append(.init(
            productUrl: "https://feo.fidele-food.ru/wp-content/uploads/2023/01/pikanto-2.webp",
            title: "Пицца «Пиканто»",
            description: "Тонкий сладкий вкус груши “Конференция” с сыром Дор Блю, орех грецкий, сливочный соус",
            price: "445")
        )
        productResponse.append(.init(
            productUrl: "https://feo.fidele-food.ru/wp-content/uploads/2023/05/Tryufelnyi-delyuks-500x417.png",
            title: "Пицца «Грибной Делюкс»",
            description: "Пицца на сливочном соусе с тремя видами грибов в сочетании с куриной ветчиной, украшена луком и укропом.",
            price: "445")
        )

        var bannerResponse = [BannerModel]()
        if let url = URL(string: "https://karta.guru/uploads/posts/2019-05/1558076290_lenta-v-telefone.png") {
            bannerResponse.append(.init(
                url: url,
                desctiption: "New mobile app")
            )
        }
        if let url = URL(string: "https://aquabalt.ru/imgs/products/639/639-1555677377.jpg") {
            bannerResponse.append(.init(
                url: url,
                desctiption: "New mobile app")
            )
        }

        presenter?.presentData(data: productResponse, dataBanner: bannerResponse)
    }
}
