//
//  OrganizationSignInView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 02.03.2024.
//

import UIKit
import SnapKit

protocol OrganizationSignInViewControllerDelegate: AnyObject {
    func update(with state: TableViewModelState)
    func didCatchError(with text: String)
    func toggleButton(with flag: Bool)
}

final class OrganizationSignInViewController: BaseViewController, OrganizationSignInViewControllerDelegate {
    
    // Dependencies
    var presenter: OrganizationSignInPresenterProtocol!
    
    // Properties
    private var bottomConstraintDoneButton: Constraint?
    
    // UI
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView()
        tableView.setup()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(InputTextCell.self, forCellReuseIdentifier: InputTextCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = R.string.localizable.signInOrganizationTitleLabelText()
        label.font = Specs.font.title1Bold
        label.textAlignment = .center
        label.textColor = .labelButton
        return label
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mainIcon()
        return imageView
    }()
    
    private lazy var doneButton: LoadingableButton = {
        let button = LoadingableButton()
        button.setTitle(R.string.localizable.commonButtonForward(), for: .normal)
        button.customizePrimary()
        button.onTouchUpInside { [weak self] in
            self?.doneButtonDidTap()
        }
        return button
    }()
    
    // MARK: - View life cyrcle
    
    override func setup() {
        presenter.setup()
        setupNotifications()
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .systemBackground
        title = R.string.localizable.signInTitle()
    }
    
    override func layout() {
        super.layout()
        let height: CGFloat = Guidelines.buttonsHeight
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(height)
            bottomConstraintDoneButton = $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Specs.constraints.mediumConstraint).constraint
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.left.top.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(doneButton.snp.top)
        }
        
        insetScrollViewIfNeeded()
        
        setUpHeaderView()
    }
    
    // MARK: - Public
    
    func update(with state: TableViewModelState) {
        switch state {
        case .initialized: break
        case .loading:
            self.tableView.isScrollEnabled = false
        case let .loaded(dataSource):
            self.tableView.isScrollEnabled = true
            self.tableView.update(dataSource: dataSource)
            self.tableView.reloadData()
        case .error:
            break
        }
    }
    
    func didCatchError(with text: String) {
        showSystemAlert(title: text, isTwoButtons: false)
    }
    
    func toggleButton(with flag: Bool) {
        doneButton.toggleLoading(isLoading: flag)
    }
    
    // MARK: - Private
    
    private func setUpHeaderView() {
        let headerView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: Guidelines.logoImageSize.height + 40
        ))
        
        headerView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Guidelines.logoImageSize)
        }
        
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.top.equalTo(logoImageView.snp.bottom).offset(Specs.constraints.middiConstraint)
            $0.bottom.equalToSuperview()
        }

        tableView.tableHeaderView = headerView
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardShowing(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardShowing(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - Actions
    
    @objc
    private func doneButtonDidTap() {
        presenter.doneButtonDidTap()
    }
    
    @objc
    private func handleKeyboardShowing(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            let isKeyBoardShgowing = notification.name == UIResponder.keyboardWillShowNotification
            
            let bottomSpace = isKeyBoardShgowing ? -(keyboardRectangle.height) : -Specs.constraints.mediumConstraint
            
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                self.bottomConstraintDoneButton?.update(offset: bottomSpace)
            })
        }
    }
}

extension OrganizationSignInViewController {
    private enum Guidelines {
        static let logoImageSize: CGSize = CGSize(width: 200, height: 200)
        static let buttonsHeight: CGFloat = CGFloat(60)
    }
}
