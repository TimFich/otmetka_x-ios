//
//  PersonSignInModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 26.01.2024.
//

import Foundation

typealias PersonSignInModuleResult = ModuleFactoryResult<PersonSignInModuleInput, 
                                                         PersonSignInModuleOutput>

extension ModulesBuilder {
    func personSignIn() -> PersonSignInModuleResult {
        PersonSignInModule().configure()
    }
}

enum PersonSignInModuleInput {}

enum PersonSignInModuleOutput {
    case needMoveToMainBlock(String)
}

struct PersonSignInModule {
    func configure() -> PersonSignInModuleResult {
        let view = PersonSignInViewController()
        let interactor = PersonSignInInteractor()
        let presenter = PersonSignInPresenter(interactor: interactor,
                                              view: view)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyModule(presenter), view)
    }
}

