//
//  UserDto.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

struct AuthDto: ApiModelToDomainProtocol {
    let login: String
    let password: String
    
    func toDomain() -> Auth {
        Auth(
            login: login,
            password: password
        )
    }
}
