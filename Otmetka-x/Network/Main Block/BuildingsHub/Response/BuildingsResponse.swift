//
//  BuildingsResponse.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 31.01.2024.
//

import Foundation

struct BuildingsResponse: ApiModelToDomainProtocol {
    let buildings: [BuildingDTO]
    
    enum CodingKeys: String, CodingKey {
        case buildings = "data"
    }

    func toDomain() -> [Building] {
        buildings.compactMap { $0.toDomain() }
    }
}
