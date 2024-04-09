//
//  CommonApiClient.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import Foundation

struct CommonApiClient {
    private static let addressSearchPath = "v1/clean/address"
    private static let converCoordinatePath = "4_1/rs/geolocate/address"
    private static let suggestAddressPath = "4_1/rs/suggest/address"
    
    
    static func fetchAddress() -> ApiClient {
        ApiClient(
            baseURL: .daDataCleaner,
            path: addressSearchPath,
            method: .get,
            task: .none,
            headers:
                [
                    .daDataToken,
                    .daDataSecretKey
                ])
    }
    
    static func suggestAddresses(parameters: SelectionListParameters) -> ApiClient {
        ApiClient(
            baseURL: .daDataSuggestions,
            path: suggestAddressPath,
            method: .get,
            task: .urlEncoded(parameters: parameters),
            headers: [.daDataToken])
    }
    
    static func convertFromCoordinate() -> ApiClient {
        ApiClient(
            baseURL: .daDataSuggestions,
            path: converCoordinatePath,
            method: .get,
            task: .none,
            headers: [.daDataToken])
    }
}
