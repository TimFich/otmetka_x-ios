//
//  SignUpModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 24.01.2024.
//

import Foundation

typealias SignUpModuleResult = ModuleFactoryResult<SignUpModuleInput, SignUpModuleOutput>

extension ModulesBuilder {
    func signUp() -> SignUpModuleResult {
        SignUpModule().configure()
    }
}

enum SignUpModuleInput {}

enum SignUpModuleOutput {
    case needMoveToMainBlock(String)
}

struct SignUpModule {
    func configure() -> SignUpModuleResult {
        let view = SignUpViewController()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter(interactor: interactor, view: view)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyModule(presenter), view)
    }
}
