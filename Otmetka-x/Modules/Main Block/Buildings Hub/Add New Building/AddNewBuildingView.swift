//
//  AddNewBuildingView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.02.2024.
//

import SnapKit
import UIKit

protocol AddNewBuildingViewControllerDelegate: AnyObject {
    func update(with state: TableViewUpdatableModelState)
    func toggleButton(with flag: Bool)
}

final class AddNewBuildingViewController: BaseViewController, AddNewBuildingViewControllerDelegate {
    // Dependencies
    var presenter: AddNewBuildingPresenterProtocol!
    
    // UI
    private var bottomConstraintDoneButton: Constraint?
    
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView()
        tableView.separatorStyle = .none
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(PreviewBuildingCell.self,
                           forCellReuseIdentifier: PreviewBuildingCell.identifier)
        tableView.register(InputTextCell.self, 
                           forCellReuseIdentifier: InputTextCell.identifier)
        tableView.setup()
        return tableView
    }()
    
    private lazy var addBuildingButton: LoadingableButton = {
        let button = LoadingableButton()
        button.setTitle(R.string.localizable.buildingHubAddBuildingAddButtonTitle(), for: .normal)
        button.customizePrimary()
        button.onTouchUpInside { [weak self] in
            self?.presenter.doneButtonDidTap()
        }
        return button
    }()
    
    // MARK: - View life cyrcle
    
    override func setup() {
        super.setup()
        presenter.setup()
        
        title = R.string.localizable.buildingHubAddBuildingTitle()
        
        let rightBarButton = UIBarButtonItem(title: R.string.localizable.commonCloseActionButton(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
        rightBarButton.tintColor = .red
        navigationItem.leftBarButtonItem = rightBarButton
        
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .systemBackground
    }
    
    override func layout() {
        super.layout()
        let height: CGFloat = Guidelines.buttonsHeight
        view.addSubview(addBuildingButton)
        addBuildingButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(height)
            bottomConstraintDoneButton = $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Specs.constraints.mediumConstraint).constraint
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.left.top.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(addBuildingButton.snp.top)
        }
        
        insetScrollViewIfNeeded()
    }
    
    // MARK: - Public
    
    func update(with state: TableViewUpdatableModelState) {
        switch state {
        case .initialized: break
        case .loading:
            self.tableView.isScrollEnabled = false
        case let .loaded(dataSource):
            self.tableView.isScrollEnabled = true
            self.tableView.update(dataSource: dataSource)
            self.tableView.reloadData()
        case let .reloadSection(dataSource, section):
            self.tableView.update(dataSource: dataSource)
            self.tableView.reloadSections(section, with: .none)
        case let .error(message):
            addBuildingButton.toggleLoading(isLoading: false)
            showSystemAlert(title: message, isTwoButtons: false)
        }
    }
    
    func toggleButton(with flag: Bool) {
        addBuildingButton.toggleLoading(isLoading: flag)
    }
    
    // MARK: - Action
    
    @objc
    private func closeButtonDidTap() {
        presenter.closeButtonDidTap()
    }
}

extension AddNewBuildingViewController {
    private enum Guidelines {
        static let buttonsHeight: CGFloat = CGFloat(60)
    }
}
