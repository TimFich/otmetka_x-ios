//
//  SignUpView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 24.01.2024.
//

import UIKit
import SnapKit

protocol SignUpViewControllerDelegate: AnyObject {
    func update(with state: TableViewModelState)
    func didCatchError(with text: String) 
    func toggleButton(with flag: Bool)
}

final class SignUpViewController: BaseViewController, SignUpViewControllerDelegate {
    
    // Dependencies
    var presenter: SignUpPresenterProtocol!
    
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
            self?.presenter.doneButtonDidTap()
        }
        return button
    }()
    
    // MARK: - View life cyrcle
    
    override func setup() {
        presenter.setUp()
        setupNotifications()
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .systemBackground
        title = R.string.localizable.registrationTitle()
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
        doneButton.toggleLoading(isLoading: false)
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
            height: Guidelines.logoImageSize.height
        ))
        
        headerView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(Guidelines.logoImageSize)
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

extension SignUpViewController {
    private enum Guidelines {
        static let logoImageSize: CGSize = CGSize(width: 200, height: 200)
        static let buttonsHeight: CGFloat = CGFloat(60)
    }
}
