//
//  PersonProfileModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

typealias PersonProfileModuleResult = ModuleFactoryResult<PersonProfileModuleInput,
                                                          PersonProfileModuleOutput>

extension ModulesBuilder {
    func personProfile() -> PersonProfileModuleResult {
        ProfileModule().configure()
    }
}

enum PersonProfileModuleInput {}

enum PersonProfileModuleOutput {
    
}

struct ProfileModule {
    func configure() -> PersonProfileModuleResult {
        let view = PersonProfileViewController()
        let interactor = PersonProfileInteractor()
        let presenter = PersonProfilePresenter(interactor: interactor,
                                               view: view)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyModule(presenter), view)
    }
}
