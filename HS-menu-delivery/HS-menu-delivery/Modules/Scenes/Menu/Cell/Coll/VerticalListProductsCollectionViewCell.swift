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

    var listModel: ListProtyctModel? {
        didSet {
            imageProduct.image = listModel?.productImage
            titleLabel.text = listModel?.title
            descriptionsLabel.text = listModel?.description
            guard let price: String = listModel?.price else { return }
            priceLabel.text = "от \(price) р"
        }
    }

    enum Constants {
        static let widthItem = 132/375 * UIScreen.main.bounds.width
    }

    private let imageProduct: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.textColor = .titleLabelList
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let descriptionsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.textColor = .descriptionLabelList
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let priceView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.priceLabelList.cgColor
        view.layer.cornerRadius = 6
        return view
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textColor = .priceLabelList
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
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

        addSubviews(imageProduct, titleLabel, descriptionsLabel, priceView)
        priceView.addSubview(priceLabel)
    }

    private func setupLayout() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        descriptionsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }

        priceView.snp.makeConstraints { make in
            make.top.equalTo(descriptionsLabel.snp.bottom).offset(20)
            make.trailing.equalTo(descriptionsLabel.snp.trailing)
            make.bottom.equalToSuperview().inset(20)
        }

        priceLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(10)
        }

        imageProduct.snp.makeConstraints { make in
            make.size.equalTo(Constants.widthItem)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalTo(titleLabel.snp.leading).inset(-25)
            make.top.equalToSuperview().offset(20)
            make.bottom.greaterThanOrEqualToSuperview().inset(20)
        }
    }
}
