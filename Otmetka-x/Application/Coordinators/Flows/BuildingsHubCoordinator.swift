//
//  BuildingsHubCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import UIKit

typealias BuildingsHubCoordinatorFactoryResult = CoordinatorFactoryResult<BuildingsHubCoordinatorInput, BuildingsHubCoordinatorOutput>

enum BuildingsHubCoordinatorInput {
    case hub
}

enum BuildingsHubCoordinatorOutput {
}

final class BuildingsHubCoordinator: NavigationCoordinator, CoordinatorProtocol {
    typealias InputType = BuildingsHubCoordinatorInput
    typealias OutputType = BuildingsHubCoordinatorOutput
    
    var output: ((OutputType) -> Void)?
    
    private var propertyReciver: ((PropertyModuleInputEvent) -> Void)?
    
    @Injected var modulesBuilder: ModulesBuilderProtocol
    @Injected var coordinatorFactory: CoordinatorFactoryProtocol
    
    init(navigationController: UINavigationController = UINavigationController()) {
        let navigator = Navigator(navController: navigationController)
        super.init(navigator: navigator)
    }
    
    func start(with type: InputType) {
        switch type {
        case .hub:
            setRootModule()
        }
    }
    
    // MARK: - Configure Module
    
    private func setRootModule() {
        if let navCon = navigator.toPresent as? UINavigationController {
            navCon.navigationBar.customizeForMainPlainTitle()
        }
        
        let presentable = makeBuildingsHub()
        navigator.setRootModule(presentable)
    }
    
    // MARK: - Show Modules
    
    private func showPropertiesList(id: Int) {
        navigator.push(makePropertiesList(id: id))
    }
    
    private func showAddBuilding() {
        let coordinator = makeAddNewBuildingFlow()
        coordinator.coordinator.start(with: .main)
        navigator.present(coordinator.presentable)
    }
    
    private func showPropertyDetailed(id: Int) {
        navigator.push(makePropertyDetailed(id: id))
    }
    
    // MARK: - Make Modules
    
    private func makeBuildingsHub() -> Presentable {
        let result = modulesBuilder.buildingsHub()
        result.module.output = { [weak self] output in
            switch output {
            case let .moveToBuildingDetailed(id):
                self?.showPropertiesList(id: id)
            case .addButtonDidTap:
                self?.showAddBuilding()
            }
        }
        return result.presentable
    }
    
    private func makePropertiesList(id: Int) -> Presentable {
        let result = modulesBuilder.property(buildingId: id)
        result.module.output = { [weak self] output in
            switch output {
            case let .showDetailed(id):
                self?.showPropertyDetailed(id: id)
            }
        }
        propertyReciver = result.module.receiver
        return result.presentable
    }
    
    private func makeAddNewBuildingFlow() -> AddNewBuildingCoordinatorFactoryResult {
        let result = coordinatorFactory.addNewBuildingCoordinator()
        addDependency(result.coordinator)
        result.coordinator.output = { [weak self] output in
            switch output {
            case .close:
                self?.removeDependency(result.coordinator)
            case .reloadDataSource:
                self?.removeDependency(result.coordinator)
                self?.setRootModule()
            }
        }
        return result
    }
    
    private func makePropertyDetailed(id: Int) -> Presentable {
        let result = modulesBuilder.propertyDetailed(propertyId: id)
        result.module.output = { [weak self] output in
            switch output {
            
            }
        }
        return result.presentable
    }
}

