//
//  AddBuildingCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import UIKit

typealias AddNewBuildingCoordinatorFactoryResult = CoordinatorFactoryResult<AddNewBuildingCoordinatorInput, AddNewBuildingCoordinatorOutput>

enum AddNewBuildingCoordinatorInput {
    case main
}

enum AddNewBuildingCoordinatorOutput {
    case close
    case reloadDataSource
}

final class AddNewBuildingCoordinator: NavigationCoordinator, CoordinatorProtocol {
    typealias InputType = AddNewBuildingCoordinatorInput
    typealias OutputType = AddNewBuildingCoordinatorOutput
    
    var output: ((OutputType) -> Void)?
    
    @Injected var modulesBuilder: ModulesBuilderProtocol
    
    init(navigationController: UINavigationController = UINavigationController()) {
        let navigator = Navigator(navController: navigationController)
        super.init(navigator: navigator)
    }
    
    func start(with type: InputType) {
        switch type {
        case .main:
            setRootModule()
        }
    }
    
    // MARK: - Configure Module
    
    private func setRootModule() {
        if let navCon = navigator.toPresent as? UINavigationController {
            navCon.navigationBar.customizeForMainPlainTitle()
        }
        
        let presentable = makeAddNewBuilding()
        navigator.setRootModule(presentable)
    }
    
    // MARK: - Show modules
    
    
    private func showAddressSearcher(with input: SelectionListModuleInputData) {
        navigator.push(makeAddressSearcher(with: input))
    }
    
    
    // MARK: - Make modules
    private func makeAddNewBuilding() -> Presentable {
        let result = modulesBuilder.addNewBuilding()
        result.module.output = { [weak self] output in
            switch output {
            case .close:
                self?.output?(.close)
                self?.navigator.dismissModule()
            case let .showAddressSelection(selection):
                self?.showAddressSearcher(with: selection)
            case .showTypePicker:
                break
            case .doneButtonDidTap:
                self?.output?(.close)
                self?.navigator.dismissModule()
            }
        }
        return result.presentable
    }
    
    
    private func makeAddressSearcher(with input: SelectionListModuleInputData) -> Presentable {
        let result = modulesBuilder.selectionList(input: input)
        result.module.output = { [weak self] output in
            switch output {
            case .close:
                self?.navigator.popModule()
            }
        }
        return result.presentable
    }
}
