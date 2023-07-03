//
//  BannerCell.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 24.06.2023.
//

import UIKit
import SnapKit

class BannerCell: UITableViewCell {

    private enum Constants {
        static let widthItem = 300/375 * UIScreen.main.bounds.width
        static let heigthItem = 112/300 * widthItem
    }

    static let cellIdentifier: String = "BannerCell"

    var dataBannerToDisplay: [BannerCellModel]? {
        didSet {
            guard dataBannerToDisplay != nil else { return }
            collectionViewCell.reloadData()
        }
    }

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: Constants.widthItem, height: Constants.heigthItem)
        layout.scrollDirection = .horizontal
        return layout
    }()

    private lazy var collectionViewCell: UICollectionView = {
        lazy var collectionViewCell = UICollectionView(frame: self.contentView.frame,
                                                       collectionViewLayout: self.layout)
        collectionViewCell.register(BannerCollectionCell.self,
                                    forCellWithReuseIdentifier: BannerCollectionCell.cellIdentifier)
        collectionViewCell.backgroundColor = .clear
        collectionViewCell.showsVerticalScrollIndicator = false
        collectionViewCell.showsHorizontalScrollIndicator = false
        collectionViewCell.bounces = false
        collectionViewCell.isUserInteractionEnabled = true
        return collectionViewCell
    }()

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
        collectionViewCell.dataSource = self
        collectionViewCell.delegate = self
        collectionViewCell.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }

    private func setuplayout() {
        contentView.addSubview(collectionViewCell)

        collectionViewCell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(Constants.heigthItem)
        }
    }
}

extension BannerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return dataBannerToDisplay?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerCollectionCell.cellIdentifier,
            for: indexPath as IndexPath
        ) as? BannerCollectionCell
        guard dataBannerToDisplay != nil else { return UICollectionViewCell() }
        cell?.model = dataBannerToDisplay?[indexPath.row]
        return cell ?? UICollectionViewCell()
    }

}

extension BannerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        CGSize(width: Constants.widthItem, height: Constants.heigthItem)
    }
}

extension BannerCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
