//
//  SelectionListView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import UIKit
import SnapKit

protocol SelectionListViewDelegate: AnyObject {
    func update(with state: TableViewModelState)
    func getSizeForPlaceholder() -> CGFloat
}

final class SelectionListViewController: BaseViewController, SelectionListViewDelegate {
    
    // Dependencies
    var presenter: SelectionListPresenterProtocol!
    
    // UI
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView()
        tableView.backgroundView = loadingIndicatior
        tableView.sectionHeaderTopPadding = 0
        tableView.register(TextCell.self,
                           forCellReuseIdentifier: TextCell.identifier)
        tableView.register(EmptySearchTableViewCell.self, 
                           forCellReuseIdentifier: EmptySearchTableViewCell.identifier)
        tableView.setup()
        return tableView
    }()
    
    private lazy var loadingIndicatior: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.startAnimating()
        loader.isHidden = true
        return loader
    }()
    
    var searchBar: UISearchBar? { navigationItem.searchController?.searchBar }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .systemBackground
        title = R.string.localizable.commonAddressSearchTitle()
        
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar?.delegate = self
    }
    
    override func setup() {
        super.setup()
        presenter.setup()
    }
    
    override func layout() {
        super.layout()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func getSizeForPlaceholder() -> CGFloat {
        view.frame.height - (navigationController?.navigationBar.frame.height ?? 0)
    }
    
    func update(with state: TableViewModelState) {
        Task { @MainActor in
            switch state {
            case .initialized:
                break
            case .loading:
                self.loadingIndicatior.isHidden = false
                self.tableView.isScrollEnabled = false
            case let .loaded(dataSource):
                self.loadingIndicatior.isHidden = true
                self.tableView.isScrollEnabled = true
                self.tableView.update(dataSource: dataSource)
                self.tableView.reloadData()
            case let .error(message):
                self.showSystemAlert(title: message,
                                     isTwoButtons: false)
            }
        }
    }
}

extension SelectionListViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        presenter.textDidChange(with: searchText)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.text = presenter.getSearchedText()
    }
}
