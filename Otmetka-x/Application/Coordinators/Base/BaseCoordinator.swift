//
//  BaseCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

class BaseCoordinator {
    weak var appActions: AppActions?
    private(set) var childCoordinators: [AnyObject] = []

    init() {
        appActions = (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator
    }

    func addDependency(_ coordinator: AnyObject) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: AnyObject) {
        guard childCoordinators.isEmpty == false else {
            return
        }

        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func removeAllDependencies() {
        childCoordinators.forEach { coordinator in
            removeDependency(coordinator)
        }
    }
}

