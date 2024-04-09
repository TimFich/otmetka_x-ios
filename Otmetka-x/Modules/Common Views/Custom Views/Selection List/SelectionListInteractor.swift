//
//  SelectionListInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import Foundation

protocol SelectionListInteractorProtocol: AnyObject {
    func fetchAddress(with parameters: SelectionListParameters)
}

final class SelectionListInteractor: SelectionListInteractorProtocol {
    
    // Dependencies
    weak var presenter: SelectionListPresenterProtocol?
    
    @Injected var commonApi: CommonApiProtocol
    
    func fetchAddress(with parameters: SelectionListParameters) {
        Task {
            do {
                let addresses = try await commonApi.suggestAddress(parameters: parameters)
                presenter?.fetchAddresses(with: addresses)
            } catch let error as ApiError {
                presenter?.didCatchError(with: error.errorDescription)
            } catch {
                presenter?.didCatchError(with: R.string.localizable.errorUnknownError())
            }
        }
    }
}
