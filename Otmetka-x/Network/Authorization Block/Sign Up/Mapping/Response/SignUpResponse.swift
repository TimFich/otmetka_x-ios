//
//  AuthorizationResponse.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

struct AuthorizationResponse: ApiModelToDomainProtocol {
    var accessToken: String
    
    func toDomain() -> Any? {
        return nil
    }
}
