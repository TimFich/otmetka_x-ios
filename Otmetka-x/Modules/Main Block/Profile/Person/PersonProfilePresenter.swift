//
//  ProfilePresenter.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

protocol PersonProfilePresenterProtocol: AnyObject {
  
}

final class PersonProfilePresenter: PersonProfilePresenterProtocol, ModuleProtocol {
    typealias InputType = PersonProfileModuleInput
    typealias OutputType = PersonProfileModuleOutput
    
    var output: ((OutputType) -> Void)?
    
    // Dependencies
    private let interactor: PersonProfileInteractorProtocol
    private weak var view: PersonProfileViewControllerDelegate?
    
    // MARK: - Initialization
    
    init(interactor: PersonProfileInteractorProtocol,
         view: PersonProfileViewControllerDelegate) {
        self.interactor = interactor
        self.view = view
    }
}
