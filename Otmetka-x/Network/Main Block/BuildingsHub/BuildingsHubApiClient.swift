//
//  BuildingsHubApiClient.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 31.01.2024.
//

import Foundation

struct BuildingsHubApiClient {
    private static let buildingsPath = "building"
    private static let propertiesPath = "property/building/"

    
    static func fetchBuildings() -> ApiClient {
        ApiClient(
            path: buildingsPath,
            method: .get,
            task: .none,
            headers: [.bearerTokenHeader])
    }
    
    static func fetchProperties(with id: Int) -> ApiClient {
        ApiClient(
            path: "\(propertiesPath)\(id)",
            method: .get,
            task: .none,
            headers: [.bearerTokenHeader])
    }
    
    static func addNewBuilding(with parameters: AddNewBuildingParameters) -> ApiClient {
        ApiClient(
            path: buildingsPath,
            method: .post,
            task: .urlEncoded(parameters: parameters),
            headers: [.bearerTokenHeader]
        )
    }
}
