//
//  BuildingsInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

protocol BuildingsHubInteractorProtocol: AnyObject {
    func fetchBuildings()
}

final class BuildingsHubInteractor: BuildingsHubInteractorProtocol {
    
    // Dependencies
    weak var presenter: BuildingsHubPresenterProtocol?
    
    // Properties
    @Injected var buildingsApi: BuildingsHubApiProtocol
    
    func fetchBuildings() {
        Task {
            do {
                let buildings = try await buildingsApi.fetchBuildings()
                presenter?.buildingsDidFetched(with: buildings)
            } catch let error as ApiError {
                if error.code == .internetError {
                    presenter?.needToShowWarning()
                }
                presenter?.didCatchErorr(with: error.errorDescription)
            } catch {
                presenter?.didCatchErorr(with: R.string.localizable.errorUnknownError())
            }
        }
    }
}
