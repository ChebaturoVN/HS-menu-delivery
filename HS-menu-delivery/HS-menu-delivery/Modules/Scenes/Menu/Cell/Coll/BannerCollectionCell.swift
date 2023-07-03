//
//  BannerCollectionCell.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 24.06.2023.
//

import UIKit
import SnapKit

final class BannerCollectionCell: UICollectionViewCell {

    static let cellIdentifier: String = "BannerCollectionIdentifier"

    var model: BannerCellModel? {
        didSet {
            guard let model = model else { return }
            bannerImage.image = model.image
        }
    }

    private var disposeBag = DisposeBag()

    private let bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        let layer: CALayer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = 10.0
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setuplayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(bannerImage)
    }

    private func setuplayout() {
        bannerImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
