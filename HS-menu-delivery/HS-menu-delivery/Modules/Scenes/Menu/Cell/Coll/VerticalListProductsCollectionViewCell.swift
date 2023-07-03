//
//  VerticalListProductsCollectionViewCell.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 03.07.2023.
//

import UIKit
import SnapKit

final class VerticalListProductsCollectionViewCell: UICollectionViewCell {

    static let cellID = "VerticalListProductsCollectionViewCellCellIndentifer"

    private let imageProduct: UIImageView = {
        let image = UIImageView()
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let descriptionsLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {


//        addSubview(nameCategoryLabel)
    }

    private func setupLayout() {

    }
}
