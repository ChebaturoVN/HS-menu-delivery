//
//  VerticalListCollectionView.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 03.07.2023.
//

import UIKit
import RxSwift
import RxRelay

final class VerticalListCollectionView: UICollectionView {

    private enum Constants {
        static let heightItem = 132/375 * UIScreen.main.bounds.width + 40
        static let widthLabelCell = UIScreen.main.bounds.width -
        VerticalListProductsCollectionViewCell.Constants.widthItem - 53
    }

    private(set) var dataList = PublishRelay<[ListProtyctModel]>()
    private(set) var scrollToIndex = PublishRelay<IndexPath>()
    private(set) var scrollToMenuIndex = PublishRelay<IndexPath?>()
    private(set) lazy var lastItemSelected = self.rx.itemSelected

    let bag = DisposeBag()

    private var listModel = [ListProtyctModel]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }

    private var categoryLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: self.categoryLayout)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {

        backgroundColor = .none
        bounces = false

        delegate = self
        dataSource = self
        register(VerticalListProductsCollectionViewCell.self, forCellWithReuseIdentifier: VerticalListProductsCollectionViewCell.cellID)
        dataList
            .bind { [weak self] value in
                self?.listModel = value
            }
            .disposed(by: bag)
        scrollToIndex
            .subscribe(onNext: { [weak self] indexPath in
            self?.scrollToItem(at: indexPath, at: .top, animated: true)
        })
        .disposed(by: bag)
    }
}

extension VerticalListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        listModel.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VerticalListProductsCollectionViewCell.cellID,
            for: indexPath) as? VerticalListProductsCollectionViewCell else { return UICollectionViewCell() }
        cell.listModel = listModel[indexPath.item]
        return cell
    }
}

extension VerticalListCollectionView: UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollToMenuIndex.accept(self.indexPathsForVisibleItems[self.indexPathsForVisibleItems.count / 2])
    }
}

extension VerticalListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let item = listModel[indexPath.item]
        let cellWidth: CGFloat = collectionView.bounds.width

        let cellHeight = calculateCellHeight(for: item, with: cellWidth)
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func calculateCellHeight(for item: ListProtyctModel, with width: CGFloat) -> CGFloat {

        let titleLabel = UILabel()
        titleLabel.text = item.title
        titleLabel.numberOfLines = 0

        let titleLabelSize = titleLabel.sizeThatFits(CGSize(width: Constants.widthLabelCell,
                                                            height: CGFloat.greatestFiniteMagnitude))
        let titleLabelHeight = titleLabelSize.height + 20

        let descriptionsLabel = UILabel()
        descriptionsLabel.text = item.description
        descriptionsLabel.numberOfLines = 0

        let descriptionsLabelSize = descriptionsLabel.sizeThatFits(CGSize(width: Constants.widthLabelCell,
                                                                          height: CGFloat.greatestFiniteMagnitude))
        let descriptionsLabelHeight = descriptionsLabelSize.height + 10

        let priceLabel = UILabel()
        priceLabel.text = item.price
        priceLabel.numberOfLines = 0

        let priceLabelSize = priceLabel.sizeThatFits(CGSize(width: Constants.widthLabelCell,
                                                            height: CGFloat.greatestFiniteMagnitude))
        let priceLabelHeight = priceLabelSize.height + 50

        let heightItem = titleLabelHeight + descriptionsLabelHeight + priceLabelHeight

        return heightItem
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
