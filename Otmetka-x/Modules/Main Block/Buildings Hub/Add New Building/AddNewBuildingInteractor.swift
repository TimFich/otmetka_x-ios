//
//  AddNewBuildingInteractor.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.02.2024.
//

import Foundation

protocol AddNewBuildingInteractorProtocol: AnyObject {
    func addNewBuilding(parameters: AddNewBuildingParameters) 
}

final class AddNewBuildingInteractor: AddNewBuildingInteractorProtocol {
    
    // Dependencies
    weak var presenter: AddNewBuildingPresenterProtocol?
    
    @Injected var buildingApi: BuildingsHubApiProtocol
    
    func addNewBuilding(parameters: AddNewBuildingParameters) {
        Task {
            do {
                let result = try await buildingApi.addNewBuilding(with: parameters)
                presenter?.update(with: result)
            } catch let error as ApiError {
                presenter?.didCatchError(with: error.errorDescription)
            } catch {
                presenter?.didCatchError(with: R.string.localizable.errorUnknownError())
            }
        }
    }
}
