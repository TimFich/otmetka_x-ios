//
//  WelcomePresenter.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol WelcomePresenterProtocol: AnyObject {
    
}

final class WelcomePresenter: WelcomePresenterProtocol, ModuleProtocol {
    typealias InputType = WelcomeModuleInput
    typealias OutputType = WelcomeModuleOutput
    
    var output: ((OutputType) -> Void)?
    
    // Dependencies
    let interactor: WelcomeInteractorProtocol
    
    // MARK: - Initialization
    init(interactor: WelcomeInteractorProtocol) {
        self.interactor = interactor
    }
}
