//
//  SignInParameters.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation
import Moya

struct SignInParameters: ApiParametersMultipartFormDataProtocol {
    var login: String?
    var password: String?
    
    func toParameters() -> SignInParameters? {
        guard let login = login,
              let password = password
        else { return nil }
        
        return SignInParameters(
            login: login,
            password: password
        )
    }
    
    func toMultipartFormData() -> [MultipartFormData] {
        guard let login = login,
              let password = password else { return [] }
        
        let multipartData: [MultipartFormData] = [
            MultipartFormData(
                provider: .data(login.data(using: .utf8)!),
                name: "login"
            ),
            MultipartFormData(
                provider: .data(password.data(using: .utf8)!),
                name: "password"
            )
        ]
        return multipartData
    }
    
    func toDictionary() -> [String : Any] {
        [:]
    }
}

