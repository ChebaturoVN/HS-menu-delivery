//
//  MenuViewController.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import UIKit
import SnapKit

protocol MenuDisplayLogic: AnyObject {
    func displayData(dataBanner: [BannerCellModel])
}

final class MenuViewController: UIViewController {

    // MARK: - External vars
    private(set) var router: MenuRouterLogic?

    // MARK: - Internal vars

    private var interactor: MenuInteractorLogic?
    private var dataBannerToDisplay = [BannerCellModel]()

    private var leftButtonNavBar: UIBarButtonItem = {
        let view = LeftButtonView()
        let barButtonItem = UIBarButtonItem(customView: view)
        return barButtonItem
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.menuBackgorund
        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let viewController = self
        let presenter = MenuPresenter()
        let iteractor = MenuInteractor()
        let router = MenuRouter()
        iteractor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = iteractor
        viewController.router = router
        router.viewController = viewController
    }

    func start() -> UINavigationController {
        let nvc = UINavigationController(rootViewController: self)
        return nvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        interactor?.downloadMenu()
    }

    private func setupUI() {
        view.backgroundColor = UIColor.menuBackgorund
        navigationItem.leftBarButtonItem = leftButtonNavBar
        configureTableView()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(BannerCell.self,
                           forCellReuseIdentifier: BannerCell.cellIdentifier)
        tableView.register(HorizontalMenuCell.self,
                           forCellReuseIdentifier: HorizontalMenuCell.cellIdentifier)
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.cellIdentifier,
                                                           for: indexPath) as? BannerCell else {
                return UITableViewCell() }
            cell.dataBannerToDisplay = dataBannerToDisplay
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HorizontalMenuCell.cellIdentifier,
                                                         for: indexPath) as? HorizontalMenuCell else {
                return UITableViewCell() }
            cell.cellDelegate = self
            return cell
        }
        return UITableViewCell()
    }
}

extension MenuViewController: MenuDisplayLogic {
    func displayData(dataBanner: [BannerCellModel]) {
        dataBannerToDisplay.removeAll()
        dataBannerToDisplay.append(contentsOf: dataBanner)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MenuViewController: SelectCollectionViewMenuItem {
    func selectItem(index: IndexPath) {
        <#code#>
    }
}
