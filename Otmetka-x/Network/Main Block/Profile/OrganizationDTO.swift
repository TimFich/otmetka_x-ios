//
//  OrganizationDTO.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation

struct OrganizationDTO: ApiModelToDomainProtocol {
    let id: Int
    let login: String
    let name: String?
    let email: String?
    let inn: String
    let ogrn: String
    let address: String?
    
    func toDomain() -> Organization {
        Organization(id: id,
                     login: login,
                     name: name,
                     email: email,
                     inn: inn,
                     ogrn: ogrn,
                     address: address)
    }
}
