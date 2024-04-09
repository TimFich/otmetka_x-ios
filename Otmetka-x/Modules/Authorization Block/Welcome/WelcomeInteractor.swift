//
//  WelcomeInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol WelcomeInteractorProtocol {}

final class WelcomeInteractor: WelcomeInteractorProtocol {
    
    // Dependencies
    weak var presenter: WelcomePresenterProtocol?
}
