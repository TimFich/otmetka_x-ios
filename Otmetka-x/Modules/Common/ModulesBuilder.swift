//
//  ModulesBuilder.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol ModulesBuilderProtocol {
    // Authorization
    func welcome() -> WelcomeModuleResult
    func signUp() -> SignUpModuleResult
    func personSignIn() -> PersonSignInModuleResult
    func organizationSignIn() -> OrganizationSignInModuleResult
    
    // MARK: - Main Block
    
    //Profile Hub
    func personProfile() -> PersonProfileModuleResult
    func organizationProfile() -> OrganizationProfileModuleResult
    
    // Building Hub
    func buildingsHub() -> BuildingsHubModuleResult
    func property(buildingId: Int) -> PropertyModuleResult
    func propertyDetailed(propertyId: Int) -> PropertyDetailedModuleResult
    func addNewBuilding() -> AddNewBuildingModuleResult
    
    // Common
    func selectionList(input: SelectionListModuleInputData) -> SelectionListModuleResult
}

struct ModulesBuilder: ModulesBuilderProtocol {}
