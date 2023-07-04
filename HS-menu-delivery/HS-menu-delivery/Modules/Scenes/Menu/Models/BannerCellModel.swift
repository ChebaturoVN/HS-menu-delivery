//
//  BannerCellModel.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 24.06.2023.
//

import UIKit

enum ListProtyctType: String, CaseIterable {
    case piza = "Пицца"
    case pasta = "Паста"
    case pies = "Пироги"
    case drinks = "Напитки"
    case shawarma = "Шаурма"
    case burgers = "Бургеры"
    case gyros = "Гирос"
    case frenchFries = "Картофель фри"
    case other = "Другое"
}

struct BannerModel {
    let url: URL
    let desctiption: String
}

struct BannerCellModel {
    let image: UIImage
    let desctiption: String
}

struct MenuCellModel {
    let productUrl: URL
    let title: String
    let description: String
    let price: String
}

struct ListProtyctModel {
    let productImage: UIImage
    let title: String
    let description: String
    let price: String
    let type: ListProtyctType
}
