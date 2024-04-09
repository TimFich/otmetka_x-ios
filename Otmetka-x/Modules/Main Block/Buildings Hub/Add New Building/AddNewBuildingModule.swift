//
//  AddNewBuildingModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.02.2024.
//

import Foundation

typealias AddNewBuildingModuleResult = ModuleFactoryResult<AddNewBuildingModuleInput,
                                                           AddNewBuildingModuleOutput>

extension ModulesBuilder {
    func addNewBuilding() -> AddNewBuildingModuleResult {
        AddNewBuildingModule().configure()
    }
}

enum AddNewBuildingModuleInput {}

enum AddNewBuildingModuleOutput {
    case close
    case showAddressSelection(SelectionListModuleInputData)
    case showTypePicker
    case doneButtonDidTap
}

struct AddNewBuildingModule {
    func configure() -> AddNewBuildingModuleResult {
        let view = AddNewBuildingViewController()
        let interactor = AddNewBuildingInteractor()
        let presenter = AddNewBuildingPresenter(interactor: interactor,
                                                view: view)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyModule(presenter), view)
    }
}
