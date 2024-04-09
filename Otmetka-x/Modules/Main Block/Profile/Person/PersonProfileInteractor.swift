//
//  ProfileInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

protocol PersonProfileInteractorProtocol: AnyObject {
    
}

final class PersonProfileInteractor: PersonProfileInteractorProtocol {
    
    // Dependencies
    weak var presenter: PersonProfilePresenterProtocol?
}
