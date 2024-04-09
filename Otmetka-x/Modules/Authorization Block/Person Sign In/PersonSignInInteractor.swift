//
//  PersonSignInInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 26.01.2024.
//

import Foundation

protocol PersonSignInInteractorProtocol: AnyObject {
    func signInPerson(parameter: SignInParameters)
}

final class PersonSignInInteractor: PersonSignInInteractorProtocol {
    
    @Injected var authorizationApi: AuthorizationApiProtocol
    
    // Dependencies
    weak var presenter: PersonSignInPresenterProtocol?
    
    func signInPerson(parameter: SignInParameters) {
        Task {
            do {
                let token = try await authorizationApi.signIn(parameters: parameter, type: .person)
                presenter?.needMoveToMainBlock(with: token)
            } catch let error as ApiError {
                presenter?.didCatchError(with: error.errorDescription)
            } catch {
                presenter?.didCatchError(with: R.string.localizable.errorUnknownError())
            }
        }
    }
}
