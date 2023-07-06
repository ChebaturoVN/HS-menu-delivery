//
//  LeftButtonView.swift
//  RealCosmetology-iOS
//
//  Created by VladimirCH on 24.06.2023.
//

import UIKit

final class LeftButtonView: UIView {

    let tapGesture = UITapGestureRecognizer()

    var setTitle: String? {
        didSet {
            guard let title = setTitle else { return }
            titleLabel.text = title
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = L10n.Country.moscow
        label.textColor = .textTitleLabel
        label.textAlignment = .left
        return label
    }()

    private var listImage = UIImageView(image: .list)

    init() {
        super.init(frame: .zero)
        setUpUI()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        self.addSubviews(titleLabel, listImage)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }

        listImage.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview()
            make.width.equalTo(14)
            make.height.equalTo(8)
        }
    }

    private func setupGesture() {
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
}
