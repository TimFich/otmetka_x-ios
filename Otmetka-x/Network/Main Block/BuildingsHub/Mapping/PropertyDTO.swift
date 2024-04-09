//
//  PropertieDTO.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation

struct PropertyDTO: ApiModelToDomainProtocol {
    let id: Int
    let name: String
    let image: String
    let buildingId: Int
    let floor: Int?
    let room: Int?
    let createdAt: String
    let user: UserDTO
    let organization: OrganizationDTO
    
    func toDomain() -> Property {
        Property(
            id: id,
            name: name,
            image: ApiUrl.api.url.deletingLastPathComponent().appendingPathComponent(image),
            buildingId: buildingId,
            floor: floor,
            room: room,
            createdAt: createdAt,
            user: user.toDomain(),
            organization: organization.toDomain()
        )
    }
}
