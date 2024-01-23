//
//  NavigationCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

class NavigationCoordinator: BaseCoordinator {
    var navigator: NavigatorProtocol

    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        super.init()
    }
}
