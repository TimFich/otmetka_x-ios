//
//  OrganizationProfilePresenter.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation

protocol OrganizationProfilePresenterProtocol: AnyObject {
  
}

final class OrganizationProfilePresenter: OrganizationProfilePresenterProtocol, ModuleProtocol {
    typealias InputType = OrganizationProfileModuleInput
    typealias OutputType = OrganizationProfileModuleOutput
    
    var output: ((OutputType) -> Void)?
    
    // Dependencies
    private let interactor: OrganizationProfileInteractorProtocol
    private weak var view: OrganizationProfileViewControllerDelegate?
    
    // MARK: - Initialization
    
    init(interactor: OrganizationProfileInteractorProtocol,
         view: OrganizationProfileViewControllerDelegate) {
        self.interactor = interactor
        self.view = view
    }
}
