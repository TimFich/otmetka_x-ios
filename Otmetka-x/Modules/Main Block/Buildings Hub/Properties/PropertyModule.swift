//
//  PropertyModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 01.02.2024.
//

import Foundation

typealias PropertyModuleResult = ModuleEventableFactoryResult<PropertyModuleInput,
                                                              PropertyModuleOutput,
                                                              PropertyModuleInputEvent>

extension ModulesBuilder {
    func property(buildingId: Int) -> PropertyModuleResult {
        PropertyModule().configure(id: buildingId)
    }
}

enum PropertyModuleInput {}

enum PropertyModuleInputEvent {
    case reloadData
}

enum PropertyModuleOutput {
    case showDetailed(Int)
}

struct PropertyModule {
    func configure(id: Int) -> PropertyModuleResult {
        let view = PropertyViewController()
        let interactor = PropertyInteractor()
        let presenter = PropertyPresenter(interactor: interactor,
                                          view: view,
                                          id: id)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyEventableModule(presenter), view)
    }
}

