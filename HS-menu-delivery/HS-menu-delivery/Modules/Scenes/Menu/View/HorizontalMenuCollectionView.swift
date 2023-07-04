//
//  HorizontalMenuCollectionView.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 26.06.2023.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class HorizontalMenuCollectionView: UICollectionView {

    private let categoryLayout = UICollectionViewFlowLayout()

    private(set) lazy var lastItemSelected = self.rx.itemSelected
    let listToMenuScroll = PublishRelay<Int>()

    let bag = DisposeBag()

    var nameCategoryArray: [ListProtyctType] = [] {
        didSet {
            self.reloadData()
            selectItem(at: [0, 0], animated: true, scrollPosition: [])
        }
    }

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

        listToMenuScroll
            .subscribe(onNext: { [weak self] value in
                print(value)
                self?.selectItem(at: IndexPath(row: value, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            })
            .disposed(by: bag)

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
        cell.nameCategoryLabel.text = nameCategoryArray[indexPath.item].rawValue
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HorizontalMenuCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalMenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let categoryFont = UIFont.systemFont(ofSize: 13)
        let categoryAttributes = [NSAttributedString.Key.font: categoryFont as Any]
        let categoryWidth = nameCategoryArray[indexPath.item].rawValue.size(withAttributes: categoryAttributes).width + 20

        return CGSize(width: categoryWidth,
                      height: collectionView.frame.height)
    }
}
