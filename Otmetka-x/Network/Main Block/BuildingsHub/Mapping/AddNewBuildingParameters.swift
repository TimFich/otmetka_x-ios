//
//  AddNewBuildingParameters.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 13.03.2024.
//

import Foundation

/// ' POST /building'
struct AddNewBuildingParameters: ApiParametersProtocol {
    var name: String
    var address: String
    var latitude: Float
    var longitude: Float
    
    enum CodingKeys: String {
        case name
        case address
        case latitude
        case longitude
    }
    
    func toDictionary() -> [String : Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary[CodingKeys.name.rawValue] = name
        dictionary[CodingKeys.address.rawValue] = address
        dictionary[CodingKeys.latitude.rawValue] = latitude
        dictionary[CodingKeys.longitude.rawValue] = longitude
        
        return dictionary
    }
}
