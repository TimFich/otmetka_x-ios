//
//  BuildingDTO.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 31.01.2024.
//

import Foundation

struct BuildingDTO: ApiModelToDomainProtocol {
    let id: Int
    let address: String
    let latitude: String
    let longitude: String
    
    func toDomain() -> Building {
        Building(
            id: id,
            address: address,
            latitude: (latitude as NSString).floatValue,
            longitude: (longitude as NSString).floatValue
        )
    }
}
