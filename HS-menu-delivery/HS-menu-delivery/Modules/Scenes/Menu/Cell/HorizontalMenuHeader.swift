//
//  HorizontalMenuCell.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 28.06.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxCocoa

final class HorizontalMenuHeader: UITableViewHeaderFooterView {

    let nameCategoryArray = PublishRelay<[ListProtyctType]>()
    let itemSelected = PublishRelay<IndexPath?>()
    let listToMenuScroll = PublishRelay<Int>()

    let bag = DisposeBag()

    private let menuCollection = HorizontalMenuCollectionView()

    init(frame: CGRect) {
        super.init(reuseIdentifier: nil)
        self.frame = frame
        setupUI()
        setuplayout()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(menuCollection)
        nameCategoryArray
            .subscribe(onNext: { [weak self] value in
                self?.menuCollection.nameCategoryArray = value
            })
            .disposed(by: bag)

        menuCollection
            .lastItemSelected
            .bind { [weak self] value in
                self?.itemSelected.accept(value)
            }
            .disposed(by: menuCollection.bag)
        listToMenuScroll
            .subscribe(onNext: { [weak self] value in
                print(value)

                self?.menuCollection.listToMenuScroll.accept(value)
            })
            .disposed(by: bag)
    }

    private func setuplayout() {
        menuCollection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(32)
        }
    }
}
