//
//  PropertyResponse.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation

struct PropertyResponse: ApiModelToDomainProtocol {
    let property: PropertyDTO
    
    func toDomain() -> Property {
        property.toDomain()
    }
}
