//
//  HorizontalMenuCollectionView.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 26.06.2023.
//

import UIKit

protocol SelectCollectionViewMenuItem: AnyObject {
    func selectItem(index: IndexPath)
}

final class HorizontalMenuCollectionView: UICollectionView {

    private let categoryLayout = UICollectionViewFlowLayout()

    private let nameCategoryArray = ["Like", "Напитки", "Пицца", "Доставка", "Рекомендованное", "Одноразовая посуда"]

    weak var cellDelegate: SelectCollectionViewMenuItem?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: categoryLayout)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        categoryLayout.minimumInteritemSpacing = 5
        categoryLayout.scrollDirection = .horizontal

        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        bounces = false
        showsHorizontalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)

        delegate = self
        dataSource = self
        register(HorizontalMenuCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalMenuCollectionViewCell.cellID)
        selectItem(at: [0, 0], animated: true, scrollPosition: [])
    }
}

// MARK: - UICollectionViewDataSource
extension HorizontalMenuCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        nameCategoryArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HorizontalMenuCollectionViewCell.cellID,
            for: indexPath) as? HorizontalMenuCollectionViewCell else { return UICollectionViewCell() }
        cell.nameCategoryLabel.text = nameCategoryArray[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HorizontalMenuCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        cellDelegate?.selectItem(index: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalMenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let categoryFont = UIFont.systemFont(ofSize: 13)
        let categoryAttributes = [NSAttributedString.Key.font: categoryFont as Any]
        let categoryWidth = nameCategoryArray[indexPath.item].size(withAttributes: categoryAttributes).width + 20

        return CGSize(width: categoryWidth,
                      height: collectionView.frame.height)
    }
}
