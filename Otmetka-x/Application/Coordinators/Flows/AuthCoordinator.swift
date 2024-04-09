//
//  AuthCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

typealias AuthCoordinatorFactoryResult = CoordinatorFactoryResult<AuthCoordinatorInput, AuthCoordinatorOutput>

enum AuthCoordinatorInput {
    case none
}

enum AuthCoordinatorOutput {
    case finish(token: String, isOrganization: Bool)
}

final class AuthCoordinator: NavigationCoordinator, CoordinatorProtocol {
    typealias InputType = AuthCoordinatorInput
    typealias OutputType = AuthCoordinatorOutput
    
    var output: ((OutputType) -> Void)?
    
    @Injected var modulesBuilder: ModulesBuilderProtocol
    
    init() {
        let navigationController = UINavigationController()
        let navigator = Navigator(navController: navigationController)
        super.init(navigator: navigator)
    }
    
    func start(with _: InputType) {
        let presentable = makeWelcome()
        
        if let navCon = navigator.toPresent as? UINavigationController {
            navCon.navigationBar.customizeForMainPlainTitle()
        }
        
        navigator.setRootModule(presentable)
    }
    
    // MARK: - Show Modules
    
    private func showSignUp() {
        navigator.push(makeSignUp())
    }
    
    private func showPersonSignIn() {
        navigator.push(makePersonSignIn())
    }
    
    private func showOrganizationSigIn() {
        navigator.push(makeOrganizationSignIn())
    }
    
    // MARK: - Make modules
    
    private func makeWelcome() -> Presentable {
        let module = modulesBuilder.welcome()
        module.module.output = { [weak self] output in
            switch output {
            case .didTapSignUp:
                self?.showSignUp()
            case .didTapPersonSignIn:
                self?.showPersonSignIn()
            case .didTapOrganizationSignIn:
                self?.showOrganizationSigIn()
            }
        }
        return module.presentable
    }
    
    private func makeSignUp() -> Presentable {
        let module = modulesBuilder.signUp()
        module.module.output = { [weak self] output in
            switch output {
            case let .needMoveToMainBlock(token):
                self?.output?(.finish(token: token, isOrganization: false))
            }
        }
        return module.presentable
    }
    
    private func makePersonSignIn() -> Presentable {
        let module = modulesBuilder.personSignIn()
        module.module.output = { [weak self] output in
            switch output {
            case let .needMoveToMainBlock(token):
                self?.output?(.finish(token: token, isOrganization: false))
            }
        }
        return module.presentable
    }
    
    private func makeOrganizationSignIn() -> Presentable {
        let module = modulesBuilder.organizationSignIn()
        module.module.output = { [weak self] output in
            switch output {
            case let .needMoveToMainBlock(token):
                self?.output?(.finish(token: token, isOrganization: true))
            }
        }
        return module.presentable
    }
}
