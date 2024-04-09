//
//  BuildingsHubModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

typealias BuildingsHubModuleResult = ModuleFactoryResult<BuildingsHubModuleInput,
                                                         BuildingsHubModuleOutput>

extension ModulesBuilder {
    func buildingsHub() -> BuildingsHubModuleResult {
        BuildingsHubModule().configure()
    }
}

enum BuildingsHubModuleInput {}

enum BuildingsHubModuleOutput {
    case moveToBuildingDetailed(Int)
    case addButtonDidTap
}

struct BuildingsHubModule {
    func configure() -> BuildingsHubModuleResult {
        let view = BuildingsHubViewController()
        let interactor = BuildingsHubInteractor()
        let presenter = BuildingsHubPresenter(interactor: interactor,
                                              view: view)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyModule(presenter), view)
    }
}
