//
//  Property.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation

struct Property {
    let id: Int
    let name: String
    let image: URL?
    let buildingId: Int
    let floor: Int?
    let room: Int?
    let createdAt: String
    let user: User
    let organization: Organization
}
