//
//  UserDTO.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation

struct UserDTO: ApiModelToDomainProtocol {
    let id: Int
    let name: String?
    let organizationId: Int
    let status: String
    
    func toDomain() -> User {
        User(id: id,
             name: name,
             organizationId: organizationId,
             status: status)
    }
}
