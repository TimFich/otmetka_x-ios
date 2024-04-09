//
//  BuildingsFilterCellViewModel.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 31.01.2024.
//

import Foundation

struct BuildingsFilterCellViewModel {
    let filters: [ChipsFilterCellViewModel]
    let onSelect: CommandWith<BuildingTypes>
}
