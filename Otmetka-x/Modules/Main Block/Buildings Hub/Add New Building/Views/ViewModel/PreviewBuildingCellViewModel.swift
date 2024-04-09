//
//  PreviewBuildingCellViewModel.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import Foundation

struct PreviewBuildingCellViewModel {
    var building: Building
    
    init(building: Building) {
        self.building = building
    }
    
    init() {
        self.building = Building(id: 0, address: "", latitude: 0.0, longitude: 0.0)
    }
}
