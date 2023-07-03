//
//  HorizontalMenuCollectionViewCell.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 26.06.2023.
//

import UIKit
import SnapKit

final class HorizontalMenuCollectionViewCell: UICollectionViewCell {

    static let cellID = "HorizontalMenuCollectionViewCellIndentifer"

    private let nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .textMenuHorizontal.withAlphaComponent(0.4)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override var isSelected: Bool {
        didSet {
            backgroundColor = self.isSelected ? .textMenuHorizontal.withAlphaComponent(0.4) : .menuBackgorund
            nameCategoryLabel.textColor = self.isSelected ? .textMenuHorizontal : .textMenuHorizontal.withAlphaComponent(0.4)
            nameCategoryLabel.font = self.isSelected ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: 13)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .menuBackgorund
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.textMenuHorizontal.withAlphaComponent(0.4).cgColor

        addSubview(nameCategoryLabel)
    }

    private func setupLayout() {
        nameCategoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
