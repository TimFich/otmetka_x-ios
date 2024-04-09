//
//  OrganizationProfileModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation

typealias OrganizationProfileModuleResult = ModuleFactoryResult<OrganizationProfileModuleInput,
                                                                OrganizationProfileModuleOutput>

extension ModulesBuilder {
    func organizationProfile() -> OrganizationProfileModuleResult {
        OrganizationProfileModule().configure()
    }
}

enum OrganizationProfileModuleInput {}

enum OrganizationProfileModuleOutput {
    
}

struct OrganizationProfileModule {
    func configure() -> OrganizationProfileModuleResult {
        let view = OrganizationProfileViewController()
        let interactor = OrganizationProfileInteractor()
        let presenter = OrganizationProfilePresenter(interactor: interactor,
                                                     view: view)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyModule(presenter), view)
    }
}

