//
//  UserResponse.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

struct UserResponse: ApiModelToDomainProtocol {
    let user: AuthDto
    
    func toDomain() -> Auth {
        user.toDomain()
    }
}

struct UserArrayResponse: ApiModelToDomainProtocol {
    let users: [AuthDto]
    
    enum CodingKeys: String, CodingKey {
        case users
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        users = try container.decode([AuthDto].self, forKey: .users)
    }
    
    func toDomain() -> [Auth] {
        users.compactMap { $0.toDomain() }
    }
}
