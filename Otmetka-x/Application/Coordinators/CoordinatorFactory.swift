//
//  CoordinatorFactory.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func authCoordinator(output: ((AuthCoordinatorOutput) -> Void)?) -> AuthCoordinatorFactoryResult
}

struct CoordinatorFactory: CoordinatorFactoryProtocol {
    func authCoordinator(output: ((AuthCoordinatorOutput) -> Void)?) -> AuthCoordinatorFactoryResult {
        let coordinator = AuthCoordinator()
        coordinator.output = output
        return (AnyCoordinator(coordinator), coordinator.navigator)
    }
}
