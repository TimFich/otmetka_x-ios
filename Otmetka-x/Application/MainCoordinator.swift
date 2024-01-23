//
//  MainCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

class MainCoordinator {
    @Injected private var coordinatorFactory: CoordinatorFactoryProtocol
    
    static let shared = MainCoordinator()
    private var window: UIWindow?
    
    private init() {}
    
    public func start(withWindow window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
        //        if UserSession.isLoggedIn() {
        //            launchMainBlock()
        //        } else {
        //            launchAuthBlock()
        //        }
        launchAuthBlock()
    }
    
    private lazy var authCoordinatorResult: AuthCoordinatorFactoryResult? = makeAuthCoordinator()
}

extension MainCoordinator {
    
    // MARK: - Make Coordinators

    private func makeAuthCoordinator() -> AuthCoordinatorFactoryResult {
        coordinatorFactory.authCoordinator { [weak self] output in
            switch output {
            case let .finish(poolingOfTokens):
//                self?.moveToMainBlock(with: poolingOfTokens)
                self?.authCoordinatorResult = nil
            }
        }
    }

    
    // MARK: - Configure Coordinators

    private func configureAuthFlow() -> Presentable {
        if let result = authCoordinatorResult {
            result.coordinator.start(with: .none)
            return result.presentable
        } else {
            authCoordinatorResult = makeAuthCoordinator()
            return configureAuthFlow().toPresent
        }
    }
    
    // MARK: - Launch Blocks
    
    private func launchAuthBlock() {
        window?.rootViewController = configureAuthFlow().toPresent
    }
}
