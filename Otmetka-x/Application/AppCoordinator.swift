//
//  AppCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

// MARK: - App Actions

protocol AppActions: AnyObject {
    func changeTabBarIndex(_ index: TabBarIndex)
}

// MARK: - Tab bar

enum TabBarIndex: Int {
    case profile
    // .....
}

// MARK: - App Coordinator

enum AppCoordinatorInput {
    case none
}

enum AppCoordinatorOutput {
    case none
}

final class AppCoordinator: BaseCoordinator, InOutableProtocol {
    typealias InputType = AppCoordinatorInput
    typealias OutputType = AppCoordinatorOutput

    var output: ((AppCoordinatorOutput) -> Void)?

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }
}

// MARK: - Unit test it

extension AppCoordinator: AppActions {
    func changeTabBarIndex(_ index: TabBarIndex) {
        let tabBarViewController = window.rootViewController as? UITabBarController
        tabBarViewController?.selectedIndex = index.rawValue
    }
}

