//
//  OrganizationProfileInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation

protocol OrganizationProfileInteractorProtocol: AnyObject {
    
}

final class OrganizationProfileInteractor: OrganizationProfileInteractorProtocol {
    
    // Dependencies
    weak var presenter: OrganizationProfilePresenterProtocol?
}

