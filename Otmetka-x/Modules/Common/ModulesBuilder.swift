//
//  ModulesBuilder.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol ModulesBuilderProtocol {
    func welcome() -> WelcomeModuleResult
}

struct ModulesBuilder: ModulesBuilderProtocol {}
