//
//  MainCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit
import SnapKit

class MainCoordinator {
    @Injected private var coordinatorFactory: CoordinatorFactoryProtocol
    
    static let shared = MainCoordinator()
    private var window: UIWindow?
    
    private init() {}
    
    public func start(withWindow window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
        if UserSession.isLoggedIn() {
            launchMainBlock()
        } else {
            launchAuthBlock()
        }
    }
    
    public func moveToMainBlock(with token: String, flag: Bool) {
        UserSession.login(with: token, isOrganization: flag)
        launchMainBlock()
    }
    
    public func logout() {
        UserSession.logout()
        launchAuthBlock()
    }
    
    private lazy var authCoordinatorResult: AuthCoordinatorFactoryResult? = makeAuthCoordinator()
    private lazy var buildingsHubCoordinatorResult: BuildingsHubCoordinatorFactoryResult? = makeBuildingsHubCoordinator()
    private lazy var profileCoordinatorResult: ProfileCoordinatorFactoryResult? = makePersonProfileCoordinator()
}

extension MainCoordinator {
    
    // MARK: - Make Coordinators

    private func makeAuthCoordinator() -> AuthCoordinatorFactoryResult {
        coordinatorFactory.authCoordinator { [weak self] output in
            switch output {
            case let .finish(token, isOrganization):
                self?.moveToMainBlock(with: token, flag: isOrganization)
                self?.authCoordinatorResult = nil
            }
        }
    }
    
    private func makeBuildingsHubCoordinator() -> BuildingsHubCoordinatorFactoryResult {
        coordinatorFactory.buildingsHubCoordinator()
    }
    
    private func makePersonProfileCoordinator() -> ProfileCoordinatorFactoryResult {
        coordinatorFactory.profileCoordinator()
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
    
    private func configureBuildingsHubFlow(with type: BuildingsHubCoordinatorInput) -> Presentable {
        if let result = buildingsHubCoordinatorResult {
            result.coordinator.start(with: type)
            return result.presentable
        } else {
            buildingsHubCoordinatorResult = makeBuildingsHubCoordinator()
            return configureBuildingsHubFlow(with: type).toPresent
        }
    }
    
    private func configureProfileFlow(with type: ProfileCoordinatorInput) -> Presentable {
        if let result = profileCoordinatorResult {
            result.coordinator.start(with: type)
            return result.presentable
        } else {
            profileCoordinatorResult = makePersonProfileCoordinator()
            return configureProfileFlow(with: type).toPresent
        }
    }
    
    // MARK: - Launch Blocks
    
    private func launchAuthBlock() {
        window?.rootViewController = configureAuthFlow().toPresent
    }
    
    private func launchMainBlock() {
        let buildingsHubFlow = configureBuildingsHubFlow(with: .hub).toPresent
        let profileFlow: UIViewController
        
        if UserSession.isOrganizationLoggedIn() {
            profileFlow = configureProfileFlow(with: .organization).toPresent
        } else {
            profileFlow = configureProfileFlow(with: .person).toPresent
        }
        
        let tabBarController = MainTabBarController()
        
        tabBarController.viewControllers = [buildingsHubFlow,
                                            profileFlow]
        tabBarController.tabBar.tintColor = .primary
        tabBarController.selectedIndex = 0
        window?.rootViewController = tabBarController
    }
}
