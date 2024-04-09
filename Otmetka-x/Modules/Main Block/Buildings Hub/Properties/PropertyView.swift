//
//  PropertyView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 01.02.2024.
//

import UIKit

protocol PropertyViewControllerDelegate: AnyObject {
    func update(with state: TableViewModelState)
}

final class PropertyViewController: BaseViewController, PropertyViewControllerDelegate {
    
    // Dependencies
    var presenter: PropertyPresenterProtocol!
    
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
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(PropertyCell.self,
                           forCellReuseIdentifier: PropertyCell.identifier)
        tableView.setup()
        return tableView
    }()
    
    private let refresher = UIRefreshControl()
    
    private lazy var deletePropertyBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: R.image.trash(),
                                        style: .plain,
                                        target: self,
                                        action: #selector(trashButtonDidTap))
        return barButton
    }()
    
    private lazy var addPropertyBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: R.image.addRectangle(),
                                        style: .plain,
                                        target: self,
                                        action: #selector(addButtonDidTap))
        return barButton
    }()
    
    override func setup() {
        presenter.setup()
    }
    
    override func layout() {
        super.layout()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
        
        insetScrollViewIfNeeded()
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .systemBackground

        tableView.backgroundView = loadingIndicatior
        tableView.refreshControl = refresher
        refresher.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        navigationItem.rightBarButtonItems = [addPropertyBarButton, deletePropertyBarButton]
    }
    
    // MARK: - Public
    
    func update(with state: TableViewModelState) {
        Task {
            await MainActor.run {
                switch state {
                case .initialized:
                    break
                case .loading:
                    self.loadingIndicatior.isHidden = false
                    self.tableView.isScrollEnabled = false
                case let .loaded(dataSource):
                    self.loadingIndicatior.isHidden = true
                    self.refresher.endRefreshing()
                    self.tableView.isScrollEnabled = true
                    self.tableView.update(dataSource: dataSource)
                    self.tableView.reloadData()
                case let .error(description):
                    showSystemAlert(title: description, isTwoButtons: false)
                }
            }
        }
    }
    
    // MARK: - Private
    
    // MARK: - Actions
    
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
        
    }
    
    @objc
    private func pullToRefresh() {
        presenter.pullToRefresh()
    }
}
