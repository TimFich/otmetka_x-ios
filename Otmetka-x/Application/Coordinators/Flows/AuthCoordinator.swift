//
//  AuthCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

typealias AuthCoordinatorFactoryResult = CoordinatorFactoryResult<AuthCoordinatorInput, AuthCoordinatorOutput>

enum AuthCoordinatorInput {
    case none
}

enum AuthCoordinatorOutput {
    case finish(poolingOfTokens: (String, String))
}

final class AuthCoordinator: NavigationCoordinator, CoordinatorProtocol {
    typealias InputType = AuthCoordinatorInput
    typealias OutputType = AuthCoordinatorOutput
    
    var output: ((OutputType) -> Void)?
    
    @Injected var modulesBuilder: ModulesBuilderProtocol
    
    init() {
        let navigationController = UINavigationController()
        let navigator = Navigator(navController: navigationController)
        super.init(navigator: navigator)
    }
    
    func start(with _: InputType) {
        let presentable = makeWelcome()
        
        if let navCon = navigator.toPresent as? UINavigationController {
            navCon.navigationBar.customizeForAuth()
        }
        
        navigator.setRootModule(presentable)
    }
    
    
    // MARK: - Make modules
    
    private func makeWelcome() -> Presentable {
        let module = modulesBuilder.welcome()
        module.module.output = { [weak self] output in
            
        }
        return module.presentable
    }
}
