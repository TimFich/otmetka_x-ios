//
//  Building.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 31.01.2024.
//

import UIKit

enum BuildingTypes: CaseIterable {
    case apartment
    case home
    case warehouse
    case unowned
    
    var description: String {
        switch self {
        case .apartment:
            return R.string.localizable.buildingHubTypesApartments()
        case .home:
            return R.string.localizable.buildingHubTypesHome()
        case .warehouse:
            return R.string.localizable.buildingHubTypesWareHouse()
        case .unowned:
            return R.string.localizable.buildingHubTypesUnowned()
        }
    }
    
    var shortDescription: String {
        switch self {
        case .apartment:
            return R.string.localizable.buildingHubFiltersApartments()
        case .home:
            return R.string.localizable.buildingHubFilterHome()
        case .warehouse:
            return R.string.localizable.buildingHubFiltersWareHouse()
        case .unowned:
            return R.string.localizable.buildingHubFiltersUnwned()
        }
    }
    
    var image: UIImage {
        switch self {
        case .apartment:
            return R.image.apartmentBuilding()!
        case .home:
            return R.image.houseBuilding()!
        case .warehouse:
            return R.image.warehouseBuilding()!
        case .unowned:
            return R.image.unownedBuilding()!
        }
    }
}

struct Building {
    let id: Int
    
    var type: BuildingTypes
    
    var name: String?
    var address: String?
    
    var latitude: Float?
    var longitude: Float?
    
    
    init(id: Int,
         type: BuildingTypes? = .unowned,
         address: String,
         latitude: Float,
         longitude: Float) {
        self.id = id
        self.type = type!
        self.name = R.string.localizable.buildingHubAddBuildingNamePlaceholder()
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}
