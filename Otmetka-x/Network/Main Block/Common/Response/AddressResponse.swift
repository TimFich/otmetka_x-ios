//
//  AddressResponse.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import Foundation

struct AddressResponse: ApiModelToDomainProtocol {
    let address: AddressDTO
    
    enum CodingKeys: String, CodingKey {
        case address = "data"
    }
    
    func toDomain() -> Address {
        address.toDomain()
    }
}

