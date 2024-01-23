//
//  DependencyStore+RegisterAll.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

extension DependencyStore {
    func registerAll() {
        register(CoordinatorFactory(), for: CoordinatorFactoryProtocol.self)
        register(ModulesBuilder(), for: ModulesBuilderProtocol.self)
        
        // Services
        //...
        // Api
        //...
    }
}
