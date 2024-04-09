//
//  ProfileCoordinator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import UIKit

typealias ProfileCoordinatorFactoryResult = CoordinatorFactoryResult<ProfileCoordinatorInput, ProfileCoordinatorOutput>

enum ProfileCoordinatorInput {
    case person
    case organization
}

enum ProfileCoordinatorOutput {
}

final class ProfileCoordinator: NavigationCoordinator, CoordinatorProtocol {
    typealias InputType = ProfileCoordinatorInput
    typealias OutputType = ProfileCoordinatorOutput
    
    var output: ((OutputType) -> Void)?
    
    @Injected var modulesBuilder: ModulesBuilderProtocol
    
    init(navigationController: UINavigationController = UINavigationController()) {
        let navigator = Navigator(navController: navigationController)
        super.init(navigator: navigator)
    }
    
    func start(with type: InputType) {
        switch type {
        case .person:
            setRootModule(with: false)
        case .organization:
            setRootModule(with: true)
        }
    }
    
    // MARK: - Configure Module
    
    private func setRootModule(with flag: Bool) {
        if let navCon = navigator.toPresent as? UINavigationController {
            navCon.navigationBar.customizeForMainPlainTitle()
        }
        if flag {
            let presentable = makeOrganizationProfile()
            navigator.setRootModule(presentable)
        } else {
            let presentable = makePersonProfile()
            navigator.setRootModule(presentable)
        }
        
        
    }
    
    // MARK: - Make Modules
    
    private func makePersonProfile() -> Presentable {
        let result = modulesBuilder.personProfile()
        result.module.output = { [weak self] output in
            switch output {
                
            }
        }
        return result.presentable
    }
    
    private func makeOrganizationProfile() -> Presentable {
        let result = modulesBuilder.organizationProfile()
        result.module.output = { [weak self] output in
            switch output {
                
            }
        }
        return result.presentable
    }
}
