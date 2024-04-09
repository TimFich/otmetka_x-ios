//
//  BuildingsHubView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import UIKit

protocol BuildingsHubViewControllerDelegate: AnyObject {
    func updateTableView(with state: TableViewModelState)
    func showInternetWarning()
}

final class BuildingsHubViewController: BaseViewController {
    
    // Dependencies
    var presenter: BuildingsHubPresenterProtocol!
    
    // UI
    private lazy var loadingIndicatior: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.startAnimating()
        loader.isHidden = true
        return loader
    }()
    
    private let tableView: BaseTableView = {
        let tableView = BaseTableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.register(BuildingCell.self,
                           forCellReuseIdentifier: BuildingCell.identifier)
        tableView.register(BuildingsFilterCell.self,
                           forCellReuseIdentifier: BuildingsFilterCell.identifier)
        tableView.setup()
        return tableView
    }()
    
    private let refresher = UIRefreshControl()
    
    private lazy var deleteBuildingBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: R.image.trash(),
                                        style: .plain,
                                        target: self,
                                        action: #selector(trashButtonDidTap))
        return barButton
    }()
    
    private lazy var addBuildingBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: R.image.addRectangle(),
                                        style: .plain,
                                        target: self,
                                        action: #selector(addButtonDidTap))
        return barButton
    }()
    
    override func setup() {
        super.setup()
        presenter.setup()
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .systemBackground
        tableView.backgroundView = loadingIndicatior
        tableView.refreshControl  = refresher
        refresher.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        navigationItem.title = R.string.localizable.buildingsHubLargeTitle()
        tabBarItem = UITabBarItem(title: R.string.localizable.buildingsHubTitle(),
                                  image: R.image.buildings(),
                                  selectedImage: R.image.buildings())
        navigationItem.rightBarButtonItem = deleteBuildingBarButton
        navigationItem.leftBarButtonItem = addBuildingBarButton
    }
    
    override func layout() {
        super.layout()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func pullToRefresh() {
        presenter.pullToRefresh()
    }
    
    @objc
    private func trashButtonDidTap() {
        if tableView.isEditing {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    
    @objc
    private func addButtonDidTap() {
        presenter.addButtonDidTap()
    }
}

extension BuildingsHubViewController: BuildingsHubViewControllerDelegate {
    func updateTableView(with state: TableViewModelState) {
        Task {
            await MainActor.run {
                switch state {
                case .initialized: break
                case .loading:
                    self.loadingIndicatior.isHidden = false
                    self.tableView.isScrollEnabled = false
                case let .loaded(dataSource):
                    self.loadingIndicatior.isHidden = true
                    self.refresher.endRefreshing()
                    self.tableView.update(dataSource: dataSource)
                    self.tableView.reloadData()
                    self.tableView.isScrollEnabled = true
                case let .error(message):
                    self.loadingIndicatior.isHidden = true
                    self.refresher.endRefreshing()
                    self.showSystemAlert(title: message, isTwoButtons: false)
                }
            }
        }
    }
    
    func showInternetWarning() {
        Task { @MainActor in
            let someView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 150))
            someView.backgroundColor = .red
            someView.layer.cornerRadius = 15
            
            view.addSubview(someView)
            someView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
            }
        }
    }
}
