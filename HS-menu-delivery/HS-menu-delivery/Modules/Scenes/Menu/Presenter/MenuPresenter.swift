//
//  MenuPresenter.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import UIKit
import Foundation

protocol MenuPresenterLogic {
    func presentData(data: [MenuCellModel], dataBanner: [BannerModel], menu: [ListProtyctType])
    func presentListCity(data: [String])
}

class MenuPresenter {

    weak var viewController: MenuDisplayLogic?
}

// MARK: - Presentation logic

extension MenuPresenter: MenuPresenterLogic {
    func presentListCity(data: [String]) {

        viewController?.presentCountry(data: data)
    }

    func presentData(data: [MenuCellModel], dataBanner: [BannerModel], menu: [ListProtyctType]) {
        Task {
            await loadModels(dataList: data, dataBanner: dataBanner, menu: menu)
        }
    }

    private func loadModels(dataList: [MenuCellModel], dataBanner: [BannerModel], menu: [ListProtyctType]) async {
        do {
            let model = try await withThrowingTaskGroup(of: BannerCellModel.self) { group in
                for item in dataBanner {
                    group.addTask {
                        return try await BannerCellModel(image: ImageManager.shared.loadImage(with: item.url),
                                                         desctiption: item.desctiption)

                    }
                }

                var result: [BannerCellModel] = []
                for try await item in group {
                    result.append(item)
                }
                return result
            }

            let modelList = try await withThrowingTaskGroup(of: ListProtyctModel.self) { group in
                for item in dataList {
                    let lowercasedString = item.title.lowercased().components(separatedBy: " ")
                    let lowercasedEnumValues = ListProtyctType.allCases.map { $0.rawValue.lowercased() }

                    group.addTask {
                        var matchingEnumCase: ListProtyctType?
                        if let value: String = lowercasedString.first(where: { word in
                            return lowercasedEnumValues.contains(word)
                        }) {
                            matchingEnumCase = ListProtyctType(rawValue: value.capitalized)
                        }

                        return try await ListProtyctModel(productImage: ImageManager.shared.loadImage(with: item.productUrl),
                                                          title: item.title,
                                                          description: item.description,
                                                          price: item.price,
                                                          type: matchingEnumCase ?? .other)
                    }
                }
                var result: [ListProtyctModel] = []
                for try await item in group {
                    result.append(item)
                }
                return result
            }

            viewController?.displayData(dataBanner: model,
                                        menu: menu,
                                        dataList: modelList.sorted(by: { $0.type.rawValue > $1.type.rawValue}))
        } catch {
            return
        }
    }

}
