//
//  MenuViewController.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import UIKit
import SnapKit

protocol MenuDisplayLogic: AnyObject {
    func displayData()
}

final class MenuViewController: UIViewController {

    // MARK: - External vars

    // MARK: - Internal vars

    private var interactor: MenuInteractorLogic?
    private var dataToDisplay = [String]()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.menuBackgorund
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let viewController = self
        let presenter = MenuPresenter()
        let iteractor = MenuInteractor()
        iteractor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = iteractor
    }

    func start() -> UINavigationController {
        let nvc = UINavigationController(rootViewController: self)
        return nvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.featchArticle()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension MenuViewController: MenuDisplayLogic {
    func displayData() {
        //---
    }
}
