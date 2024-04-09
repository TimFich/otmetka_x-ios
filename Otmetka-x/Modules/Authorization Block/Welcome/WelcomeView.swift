//
//  WelcomeView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit
import SnapKit

protocol WelcomeViewControllerDelegate: AnyObject {}

final class WelcomeViewController: BaseViewController {

    // Dependencies
    var presenter: WelcomePresenterProtocol!

    // UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = R.string.localizable.welcomeTitleLabel()
        label.font = Specs.font.largeTitleBold
        label.textAlignment = .center
        label.textColor = .labelButton
        return label
    }()

    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = R.image.mainIcon()
        return image
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpButton,
                                                       personSigninButton,
                                                       organizationSigninButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Specs.constraints.largeConstraint
        return stackView
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.registrationTitle(), for: .normal)
        button.customizePrimary()
        button.onTouchUpInside { [weak self] in
            self?.signUpButtonDidTap()
        }
        return button
    }()
    
    private lazy var personSigninButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.signInTitle(), for: .normal)
        button.customizePrimary()
        button.onTouchUpInside { [weak self] in
            self?.personSigninButtonDidTap()
        }
        return button
    }()
    
    private lazy var organizationSigninButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.welcomeButtonOrganizationSignin(), for: .normal)
        button.customizePrimary()
        button.onTouchUpInside { [weak self] in
            self?.organizationSigninButtonDidTap()
        }
        return button
    }()
    
    // MARK: - View life cyrcle
    
    override func setup() {
        super.setup()
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .systemBackground
    }
    
    override func layout() {
        super.layout()
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Guidelines.logoImageSize)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Specs.constraints.extraLargeConstraint)
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
        
        view.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Specs.constraints.mediumConstraint)
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(Guidelines.buttonsHeight)
            $0.left.right.equalToSuperview()
        }
        
        personSigninButton.snp.makeConstraints {
            $0.height.equalTo(Guidelines.buttonsHeight)
            $0.left.right.equalToSuperview()
        }
        
        organizationSigninButton.snp.makeConstraints {
            $0.height.equalTo(Guidelines.buttonsHeight)
            $0.left.right.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func signUpButtonDidTap() {
        presenter.signUpButtonDidTap()
    }
    
    @objc
    private func personSigninButtonDidTap() {
        presenter.personSigninButtonDidTap()
    }
    
    @objc
    private func organizationSigninButtonDidTap() {
        presenter.organizationSigninButtonDidTap()
    }
}

// MARK: - Guidelines

extension WelcomeViewController {
    private enum Guidelines {
        static let logoImageSize: CGSize = CGSize(width: 255, height: 255)
        static let buttonsHeight: CGFloat = CGFloat(60)
    }
}
