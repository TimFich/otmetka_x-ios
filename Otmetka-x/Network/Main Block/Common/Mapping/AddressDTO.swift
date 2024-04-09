//
//  AddressDTO.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import Foundation

struct AddressDTO: ApiModelToDomainProtocol {
    let value: String
    let unrestrictedValue: String
    let data: AddressDetailedDataDTO
    
    func toDomain() -> Address {
        let data = data.toDomain()
        
        return Address(name: value,
                       latitude: data.latitude,
                       longitude: data.lontitude)
    }
}
