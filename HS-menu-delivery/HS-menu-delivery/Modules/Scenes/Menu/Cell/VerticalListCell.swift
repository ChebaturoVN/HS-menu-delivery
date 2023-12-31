//
//  VerticalListCell.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 03.07.2023.
//

import UIKit
import SnapKit
import RxRelay
import RxSwift

final class VerticalListCell: UITableViewCell {

    static let cellIdentifier: String = "VerticalListCell"

    let dataList = PublishRelay<[ListProtyctModel]>()
    let listScroll = PublishRelay<Int>()
    let scrollToMenuIndex = PublishRelay<IndexPath?>()

    let bag = DisposeBag()

    private let listCollection = VerticalListCollectionView()

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
        dataList
            .bind { [weak self] value in
                self?.listCollection.dataList.accept(value)
            }
            .disposed(by: bag)

        listScroll
            .subscribe(onNext: { [weak self] value in
                self?.listCollection.scrollToIndex
                    .accept(IndexPath(row: value, section: 0))
            })
            .disposed(by: bag)

        listCollection.scrollToMenuIndex
            .subscribe(onNext: { [weak self] indexPath in
            self?.scrollToMenuIndex.accept(indexPath)
        })
            .disposed(by: listCollection.bag)

        backgroundColor = .clear
        contentView.addSubview(listCollection)
    }

    private func setuplayout() {
        listCollection.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(MenuViewController.Constants.heightListCell)
        }
    }
}
