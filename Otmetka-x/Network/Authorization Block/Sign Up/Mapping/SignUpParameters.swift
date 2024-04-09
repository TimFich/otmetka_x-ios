//
//  SignUpParameters.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import Foundation
import Moya

struct SignUpParameters: ApiParametersMultipartFormDataProtocol {
    var login: String?
    var password: String?
    var INN: String?
    var OGRN: String?
    var organizationName: String?
    
    func toParameters() -> SignUpParameters? {
        guard let login = login,
              let password = password,
              let INN = INN,
              let OGRN = OGRN,
              let organizationName = organizationName else { return nil }
        return SignUpParameters(
            login: login,
            password: password,
            INN: INN,
            OGRN: OGRN,
            organizationName: organizationName
        )
    }
    
    func toMultipartFormData() -> [MultipartFormData] {
        guard let login = login,
              let password = password,
              let INN = INN,
              let OGRN = OGRN,
              let organizationName = organizationName else { return [] }
        
        var multipartData: [MultipartFormData] = [
            MultipartFormData(
                provider: .data(login.data(using: .utf8)!),
                name: "login"
            ),
            MultipartFormData(
                provider: .data(password.data(using: .utf8)!),
                name: "password"
            ),
            MultipartFormData(
                provider: .data(INN.data(using: .utf8)!),
                name: "inn"
            ),
            MultipartFormData(
                provider: .data(OGRN.data(using: .utf8)!),
                name: "ogrn"
            ),
            MultipartFormData(
                provider: .data(organizationName.data(using: .utf8)!),
                name: "name"
            )
            
        ]

        return multipartData
    }
    
    func toDictionary() -> [String : Any] {
        [:]
    }
}
