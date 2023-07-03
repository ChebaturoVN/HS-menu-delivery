//
//  HorizontalMenuCell.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 28.06.2023.
//

import UIKit
import SnapKit

final class HorizontalMenuCell: UITableViewCell {

    static let cellIdentifier: String = "HorizontalMenuCell"

    weak var cellDelegate: SelectCollectionViewMenuItem?

    private let menuCollection = HorizontalMenuCollectionView()

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setuplayout()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(menuCollection)
        cellDelegate = menuCollection.cellDelegate
    }

    private func setuplayout() {
        menuCollection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(32)
        }
    }
}
