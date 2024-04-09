//
//  SignUpInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 24.01.2024.
//

import Foundation

protocol SignUpInteractorProtocol: AnyObject {
    func signUpUser(parameter: SignUpParameters)
}

final class SignUpInteractor: SignUpInteractorProtocol {
    
    @Injected var authorizationApi: AuthorizationApiProtocol
    
    // Dependencies
    weak var presenter: SignUpPresenterProtocol?
    
    func signUpUser(parameter: SignUpParameters) {
        Task {
            do {
                let token = try await authorizationApi.signUp(parameters: parameter)
                presenter?.needMoveToMainBlock(with: token)
            } catch let error as ApiError {
                presenter?.didCatchError(with: error.errorDescription)
            } catch {
                presenter?.didCatchError(with: R.string.localizable.errorUnknownError())
            }
        }
    }
}
