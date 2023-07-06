//
//  ImageManager.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 25.06.2023.
//

import Foundation
import Kingfisher

final class ImageManager {
    static let shared = ImageManager()

    private init() {}

    func loadImage(with imageURL: URL) async throws -> UIImage {
        let data = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<UIImage, Error>) in
            KingfisherManager.shared.retrieveImage(with: imageURL,
                                                   options: nil,
                                                   progressBlock: nil,
                                                   downloadTaskUpdated: nil,
                                                   completionHandler: { result in
                switch result {
                case .success(let result):
                    continuation.resume(returning: result.image)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            })
        }
        return data
    }
}
