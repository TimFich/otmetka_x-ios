//
//  CoordinatorFactory.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func authCoordinator(output: ((AuthCoordinatorOutput) -> Void)?) -> AuthCoordinatorFactoryResult
    func profileCoordinator() -> ProfileCoordinatorFactoryResult
    func buildingsHubCoordinator() -> BuildingsHubCoordinatorFactoryResult
    func addNewBuildingCoordinator() -> AddNewBuildingCoordinatorFactoryResult
}

struct CoordinatorFactory: CoordinatorFactoryProtocol {
    func authCoordinator(output: ((AuthCoordinatorOutput) -> Void)?) -> AuthCoordinatorFactoryResult {
        let coordinator = AuthCoordinator()
        coordinator.output = output
        return (AnyCoordinator(coordinator), coordinator.navigator)
    }
    
    func profileCoordinator() -> ProfileCoordinatorFactoryResult {
        let coordinator = ProfileCoordinator()
        return (AnyCoordinator(coordinator), coordinator.navigator)
    }
    
    func buildingsHubCoordinator() -> BuildingsHubCoordinatorFactoryResult {
        let coordinator = BuildingsHubCoordinator()
        return (AnyCoordinator(coordinator), coordinator.navigator)
    }
    
    func addNewBuildingCoordinator() -> AddNewBuildingCoordinatorFactoryResult {
        let coordinator = AddNewBuildingCoordinator()
        return (AnyCoordinator(coordinator), coordinator.navigator)
    }
}
