//
//  AddressDetailedData.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 15.03.2024.
//

import Foundation

struct AddressDetailedData {
    var latitude: Float
    var lontitude: Float
}

struct AddressDetailedDataDTO: ApiModelToDomainProtocol {
    var geoLat: String?
    var geoLon: String?
    
    func toDomain() -> AddressDetailedData {
        guard let geoLat = geoLat,
              let geoLon = geoLon,
              let latitude = Float(geoLat),
              let lontitude = Float(geoLon) else { return AddressDetailedData(latitude: 0, lontitude: 0)}
        return AddressDetailedData(latitude: latitude,
                            lontitude: lontitude)
    }
}
