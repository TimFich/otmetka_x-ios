//
//  WelcomeModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

typealias WelcomeModuleResult = ModuleFactoryResult<WelcomeModuleInput, WelcomeModuleOutput>

extension ModulesBuilder {
    func welcome() -> WelcomeModuleResult {
        WelcomeModule().configure()
    }
}

enum WelcomeModuleInput {}

enum WelcomeModuleOutput {
    case didTapPersonSignIn
    case didTapOrganizationSignIn
    case didTapSignUp
}

struct WelcomeModule {
    func configure() -> WelcomeModuleResult {
        let view = WelcomeViewController()
        let interactor = WelcomeInteractor()
        let presenter = WelcomePresenter(interactor: interactor)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyModule(presenter), view)
    }
}
