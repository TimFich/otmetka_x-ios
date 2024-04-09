//
//  AddressListResponse.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import Foundation

struct AddressListResponse: ApiModelToDomainProtocol {
    let addresses: [AddressDTO]
    
    enum CodingKeys: String, CodingKey {
        case addresses = "suggestions"
    }
    
    func toDomain() -> [Address] {
        addresses.compactMap { $0.toDomain() }
    }
}
