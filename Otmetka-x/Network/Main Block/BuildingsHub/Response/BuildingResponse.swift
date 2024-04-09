//
//  BuildingResponse.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 13.03.2024.
//

import Foundation

struct BuildingResponse: ApiModelToDomainProtocol {
    let building: BuildingDTO
    
    enum CodingKeys: String, CodingKey {
        case building = "data"
    }

    func toDomain() -> Building {
        building.toDomain()
    }
}
