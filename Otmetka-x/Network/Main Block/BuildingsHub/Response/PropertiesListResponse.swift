//
//  PropertiesListResponse.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation

struct PropertiesListResponse: ApiModelToDomainProtocol {
    let properties: [PropertyDTO]
    
    enum CodingKeys: String, CodingKey {
        case properties = "data"
    }
    
    func toDomain() -> [Property] {
        properties.compactMap { $0.toDomain() }
    }
}
