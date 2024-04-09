//
//  CommonApi.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import Foundation
import Moya

protocol CommonApiProtocol {
//    func standartAddress() async throws -> [Address]
    func suggestAddress(parameters: SelectionListParameters) async throws -> [Address]
//    func clearAddress() async throws -> Address
}

struct CommonApi: CommonApiProtocol {
    private let provider = MoyaProvider<ApiClient>()
    private let mapper = JSONMapper()
    
    
//    func standartAddress() async throws -> [Address] {
//        
//    }
//    
    func suggestAddress(parameters: SelectionListParameters) async throws -> [Address] {
        typealias Continuation = CheckedContinuation<[Address], Error>
        let api = CommonApiClient.suggestAddresses(parameters: parameters)
        
        return try await withCheckedThrowingContinuation { (continuation: Continuation) in
            provider.request(api) { result in
                switch result {
                case let .success(response):
                    if let response: AddressListResponse = try? mapper.parseResponse(data: response.data) {
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
//    
//    func clearAddress() async throws -> Address {
//        
//    }
}


