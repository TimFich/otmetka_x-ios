//
//  BuildingDetailedInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 01.02.2024.
//

import Foundation

protocol PropertyInteractorProtocol: AnyObject {
    func fetchProperties(with id: Int)
}

final class PropertyInteractor: PropertyInteractorProtocol {
    
    // Dependencies
    weak var presenter: PropertyPresenterProtocol?
    
    @Injected var buildingApi: BuildingsHubApiProtocol
    
    func fetchProperties(with id: Int) {
        Task {
            do {
                let properties = try await buildingApi.fetchProperties(id: id)
                presenter?.didFetchProperties(with: properties)
            } catch let error as ApiError{
                presenter?.didCatchError(with: error.errorDescription)
            } catch {
                presenter?.didCatchError(with: R.string.localizable.errorUnknownError())
            }
        }
        
    }
}
