//
//  MenuInteractor.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import Foundation

protocol MenuInteractorLogic {
    func downloadMenu()
    func tapLeftButtonView()
}

class MenuInteractor {
    private lazy var countryName: CountryNameServiceProtocol = CountryNameService()

    private var listCity: [String]?
    // MARK: - External vars
    var presenter: MenuPresenterLogic?
}

// MARK: - Business logic
extension MenuInteractor: MenuInteractorLogic {
    func tapLeftButtonView() {
        guard let listCity = listCity else { return }
        self.presenter?.presentListCity(data: listCity)
    }

    func downloadMenu() {
        var productResponse = [MenuCellModel]()
        if let url = URL(string: "https://feo.fidele-food.ru/wp-content/uploads/2023/01/panchetta-2.webp") {
            productResponse.append(.init(
                productUrl: url,
                title: "Пицца «Панчетта»",
                description: "Сытная пицца на томатном соусе с запеченными колбасками Пепперони, Краковской колбасой, ветчиной и беконом, зеленым луком и моцареллой",
                price: "505")
            )
        }
        if let url = URL(string: "https://feo.fidele-food.ru/wp-content/uploads/2023/01/pikanto-2.webp") {
            productResponse.append(.init(
                productUrl: url,
                title: "Пицца «Пиканто»",
                description: "Тонкий сладкий вкус груши “Конференция” с сыром Дор Блю, орех грецкий, сливочный соус",
                price: "445")
            )
        }
        if let url = URL(string: "https://feo.fidele-food.ru/wp-content/uploads/2023/05/Tryufelnyi-delyuks-500x417.png") {
            productResponse.append(.init(
                productUrl: url,
                title: "Пицца «Грибной Делюкс»",
                description: "Пицца на сливочном соусе с тремя видами грибов в сочетании с куриной ветчиной, украшена луком и укропом.",
                price: "445")
            )
        }

        if let url = URL(string: "https://feo.fidele-food.ru/wp-content/uploads/2023/06/pasta-karbonara-belyi-fon-1024x853.png") {
            productResponse.append(.init(
                productUrl: url,
                title: "Паста «Карбонара»",
                description: "Итальянская паста с обжаренным беконом, репчатый лук, сыром пармезан и сливочным соусом.",
                price: "355")
            )
        }
        if let url = URL(string: "https://feo.fidele-food.ru/wp-content/uploads/2023/06/pasta-s-krevetkoi-v-slivochnom-souse-belyi-fon-1024x853.png") {
            productResponse.append(.init(
                productUrl: url,
                title: "Паста с креветками в сливочном соусе",
                description: "Знаменитая паста “Мафальдине” с креветками в сливках, сыром Виола, чесноком, репчатым луком и петрушкой, посыпанная солью и перцем",
                price: "365")
            )
        }

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

        let menuType: [ListProtyctType] = ListProtyctType.allCases

        countryName.getCityList { city in
            if let city = city {
                self.listCity = city
            }
        }

        presenter?.presentData(data: productResponse, dataBanner: bannerResponse, menu: menuType)
    }
}
