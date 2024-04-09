//
//  BuildingsHubApi.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 31.01.2024.
//

import Foundation
import Moya

protocol BuildingsHubApiProtocol {
    func fetchBuildings() async throws -> [Building]
    func fetchProperties(id: Int) async throws -> [Property]
    func addNewBuilding(with parameters: AddNewBuildingParameters) async throws -> Bool
}

struct BuildingsHubApi: BuildingsHubApiProtocol {
    private let provider = MoyaProvider<ApiClient>()
    private let mapper = JSONMapper()
    
    
    func fetchBuildings() async throws -> [Building] {
        typealias Continuation = CheckedContinuation<[Building], Error>
        let api = BuildingsHubApiClient.fetchBuildings()
        
        return try await withCheckedThrowingContinuation { (continuation: Continuation) in
            provider.request(api) { result in
                switch result {
                case let .success(response):
                    if let response: BuildingsResponse = try? mapper.parseResponse(data: response.data) {
                        continuation.resume(returning: response.toDomain())
                    } else {
                        continuation.resume(throwing: ApiError(errorText: R.string.localizable.errorUnknownError()))
                    }
                case let .failure(error):
                    continuation.resume(throwing: ApiError(error: error))
                }
            }
        }
    }
    
    func fetchProperties(id: Int) async throws -> [Property] {
        typealias Continuation = CheckedContinuation<[Property], Error>
        let api = BuildingsHubApiClient.fetchProperties(with: id)
        
        return try await withCheckedThrowingContinuation { (continuation: Continuation) in
            provider.request(api) { result in
                switch result {
                case let .success(response):
                    if let response: PropertiesListResponse = try? mapper.parseResponse(data: response.data) {
                        continuation.resume(returning: response.toDomain())
                    } else {
                        continuation.resume(throwing: ApiError(errorText: R.string.localizable.errorUnknownError()))
                    }
                case let .failure(error):
                    continuation.resume(throwing: ApiError(error: error))
                }
            }
        }
    }
    
    func addNewBuilding(with parameters: AddNewBuildingParameters) async throws -> Bool {
        typealias Continuation = CheckedContinuation<Bool, Error>
        let api = BuildingsHubApiClient.addNewBuilding(with: parameters)
        
        return try await withCheckedThrowingContinuation { (continuation: Continuation) in
            provider.request(api) { result in
                switch result {
                case let .success(response):
                    if let _: BuildingResponse = try? mapper.parseResponse(data: response.data) {
                        continuation.resume(returning: true)
                    } else {
                        continuation.resume(throwing: ApiError(errorText: R.string.localizable.errorUnknownError()))
                    }
                case let .failure(error):
                    continuation.resume(throwing: ApiError(error: error))
                }
            }
        }
    }
}
