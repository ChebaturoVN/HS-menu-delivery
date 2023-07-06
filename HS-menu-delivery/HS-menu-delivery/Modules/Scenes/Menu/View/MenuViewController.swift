//
//  MenuViewController.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 22.06.2023.
//

import UIKit
import SnapKit
import RxRelay
import RxSwift
import DropDown

protocol MenuDisplayLogic: AnyObject {
    func displayData(dataBanner: [BannerCellModel], menu: [ListProtyctType], dataList: [ListProtyctModel])
    func presentCountry(data: [String])
}

final class MenuViewController: UIViewController {

    enum Constants {
        static var heightListCell: CGFloat = 1
    }

    private let dataList = PublishRelay<[ListProtyctModel]>()
    private let listScroll = PublishRelay<Int>()

    let bag = DisposeBag()

    // MARK: - External vars
    private(set) var router: MenuRouterLogic?

    // MARK: - Internal vars

    private var interactor: MenuInteractorLogic?

    private var dataBannerToDisplay = [BannerCellModel]()
    private var nameCategoryArray = [ListProtyctType]()
    private var listProtyctData = [ListProtyctModel]()

    private let menu = DropDown()
    private lazy var leftButtonView = LeftButtonView()

    private lazy var leftButtonNavBar: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(customView: self.leftButtonView)
        return barButtonItem
    }()

    private let headerFrame = CGRect(
        x: 0,
        y: 0,
        width: UIScreen.main.bounds.width,
        height: 32)

    private let headerView: HorizontalMenuHeader

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
        headerView = HorizontalMenuHeader(frame: headerFrame)
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
        Constants.heightListCell = view.safeAreaLayoutGuide.layoutFrame.height - BannerCell.Constants.heigthItem

        let tapLeftButtonView = self.leftButtonView.tapGesture.rx.event.asObservable()

        tapLeftButtonView.subscribe(onNext: { _ in
            self.interactor?.tapLeftButtonView()
        }).disposed(by: bag)

        menu.anchorView = self.navigationController?.navigationBar
        menu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.leftButtonView.setTitle = item
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(BannerCell.self,
                           forCellReuseIdentifier: BannerCell.cellIdentifier)
        tableView.register(VerticalListCell.self,
                           forCellReuseIdentifier: VerticalListCell.cellIdentifier)
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.cellIdentifier,
                                                           for: indexPath) as? BannerCell else {
                return UITableViewCell() }
            cell.dataBannerToDisplay = dataBannerToDisplay
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VerticalListCell.cellIdentifier,
                                                         for: indexPath) as? VerticalListCell else {
                return UITableViewCell() }

            dataList
                .bind { value in
                    cell.dataList.accept(value)
            }
            .disposed(by: bag)

            listScroll
                .bind { value in
                    cell.listScroll.accept(value)
                }
                .disposed(by: bag)

            cell.scrollToMenuIndex
                .subscribe(onNext: { [weak self] indexPath in
                    if let indexPath = indexPath,
                       let item = self?.listProtyctData[indexPath.row],
                       let index = self?.nameCategoryArray.firstIndex(where: { $0 == item.type }) {
                        self?.headerView.listToMenuScroll.accept(index)
                    }
                })
                .disposed(by: cell.bag)

            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            headerView.nameCategoryArray.accept(nameCategoryArray)
            headerView
                .itemSelected
                .bind { [weak self] value in
                    guard let value = value else { return }
                    self?.searchDesiredCell(value)
                }
                .disposed(by: headerView.bag)

            return headerView
        }
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    func searchDesiredCell(_ indexPath: IndexPath) {
        let element = nameCategoryArray[indexPath.row]
        if let row = listProtyctData.firstIndex(where: {
            $0.type == element
        }) {
            listScroll.accept(row)
        }
    }
}

extension MenuViewController: MenuDisplayLogic {
    func presentCountry(data: [String]) {
        menu.dataSource = data
        menu.show()
    }

    func displayData(dataBanner: [BannerCellModel], menu: [ListProtyctType], dataList: [ListProtyctModel]) {

            dataBannerToDisplay.removeAll()
            dataBannerToDisplay.append(contentsOf: dataBanner)
            nameCategoryArray = menu
            self.dataList.accept(dataList)
            listProtyctData = dataList
        Task {
            tableView.reloadData()
        }
    }
}

extension MenuViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}
