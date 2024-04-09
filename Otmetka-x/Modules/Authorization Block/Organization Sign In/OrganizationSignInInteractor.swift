//
//  OrganizationSignInInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 02.03.2024.
//

import Foundation

protocol OrganizationSignInInteractorProtocol: AnyObject {
    func organizationSignIn(with parameter: SignInParameters)
}

final class OrganizationSignInInteractor: OrganizationSignInInteractorProtocol {
    
    @Injected var authorizationApi: AuthorizationApiProtocol
    
    // Dependencies
    weak var presenter: OrganizationSignInPresenterProtocol?
    
    func organizationSignIn(with parameter: SignInParameters) {
        Task {
            do {
                let token = try await authorizationApi.signIn(parameters: parameter, type: .organization)
                presenter?.needMoveToMainBlock(with: token)
            } catch let error as ApiError {
                presenter?.didCatchError(with: error.errorDescription)
            } catch {
                presenter?.didCatchError(with: R.string.localizable.errorUnknownError())
            }
        }
    }
}

