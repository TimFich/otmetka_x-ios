//
//  PropertyDetailedModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 15.03.2024.
//

import Foundation

typealias PropertyDetailedModuleResult = ModuleEventableFactoryResult<PropertyDetailedModuleInput,
                                                                      PropertyDetailedModuleOutput,
                                                                      PropertyDetailedModuleInputEvent>

extension ModulesBuilder {
    func propertyDetailed(propertyId: Int) -> PropertyDetailedModuleResult {
        PropertyDetailedModule().configure(id: propertyId)
    }
}

enum PropertyDetailedModuleInputEvent {
    case reloadData
}

enum PropertyDetailedModuleInput {}

enum PropertyDetailedModuleOutput {

}

struct PropertyDetailedModule {
    func configure(id: Int) -> PropertyDetailedModuleResult {
        let view = PropertyDetailedViewController()
        let interactor = PropertyDetailedInteractor()
        let presenter = PropertyDetailedPresenter(interactor: interactor,
                                                  view: view,
                                                  id: id)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyEventableModule(presenter), view)
    }
}
