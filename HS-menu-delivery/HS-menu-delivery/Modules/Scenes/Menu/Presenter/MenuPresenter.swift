//
//  MenuPresenter.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import UIKit

protocol MenuPresenterLogic {
    func presentData(data: [MenuCellModel], dataBanner: [BannerModel])

}

class MenuPresenter {

    weak var viewController: MenuDisplayLogic?
}

// MARK: - Presentation logic

extension MenuPresenter: MenuPresenterLogic {
    func presentData(data: [MenuCellModel], dataBanner: [BannerModel]) {
        Task {
            await loadModels(dataBanner)
        }
    }

    private func loadModels(_ dataBanner: [BannerModel]) async {
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
            viewController?.displayData(dataBanner: model)
        } catch {
            return
        }
    }

}
