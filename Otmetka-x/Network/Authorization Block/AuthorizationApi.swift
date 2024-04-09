//
//  AuthorizationApi.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation
import Moya

enum AuthorizationApiSignInRequestType {
    case person
    case organization
}

protocol AuthorizationApiProtocol {
    func signUp(parameters: SignUpParameters) async throws -> String
    func signIn(parameters: SignInParameters, 
                type: AuthorizationApiSignInRequestType) async throws -> String
}

struct AuthorizationApi: AuthorizationApiProtocol {
    private let provider = MoyaProvider<ApiClient>()
    private let mapper = JSONMapper()
    
    func signUp(parameters: SignUpParameters) async throws -> String {
        typealias Continuation = CheckedContinuation<String, Error>
        let api = AuthorizationApiClient.signUp(parameters: parameters)
        
        return try await withCheckedThrowingContinuation { (continuation: Continuation) in
            provider.request(api) { result in
                switch result {
                case let .success(response):
                    if let response: AuthorizationResponse = try? mapper.parseResponse(data: response.data) {
                        continuation.resume(returning: response.accessToken)
                    } else {
                        continuation.resume(throwing: ApiError(errorText: R.string.localizable.errorUnknownError()))
                    }
                case let .failure(error):
                    continuation.resume(throwing: ApiError(error: error))
                }
            }
        }
    }
    
    func signIn(parameters: SignInParameters, 
                type: AuthorizationApiSignInRequestType) async throws -> String {
        typealias Continuation = CheckedContinuation<String, Error>
        var api: ApiClient
        
        switch type {
        case .person:
            api = AuthorizationApiClient.personSignIn(parameters: parameters)
        case .organization:
            api = AuthorizationApiClient.organizationSigIn(parameters: parameters)
        }
        
        return try await withCheckedThrowingContinuation { (continuation: Continuation) in
            provider.request(api) { result in
                switch result {
                case let .success(response):
                    if let response: AuthorizationResponse = try? mapper.parseResponse(data: response.data) {
                        continuation.resume(returning: response.accessToken)
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
