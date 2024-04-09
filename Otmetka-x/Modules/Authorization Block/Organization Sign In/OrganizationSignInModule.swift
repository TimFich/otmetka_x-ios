//
//  OrganizationSignInModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 02.03.2024.
//

import Foundation

typealias OrganizationSignInModuleResult = ModuleFactoryResult<OrganizationSignInModuleInput,
                                                               OrganizationSignInModuleOutput>

extension ModulesBuilder {
    func organizationSignIn() -> OrganizationSignInModuleResult {
        OrganizationSignInModule().configure()
    }
}

enum OrganizationSignInModuleInput {}

enum OrganizationSignInModuleOutput {
    case needMoveToMainBlock(String)
}

struct OrganizationSignInModule {
    func configure() -> OrganizationSignInModuleResult {
        let view = OrganizationSignInViewController()
        let interactor = OrganizationSignInInteractor()
        let presenter = OrganizationSignInPresenter(interactor: interactor,
                                                    view: view)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyModule(presenter), view)
    }
}


