//
//  ApiUrls.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import Foundation

#if DEBUG
    let isProduction = false
#else
    let isProduction = true
#endif

let isProductionApi = isProduction ? true : false

enum ApiUrlConstants {
    static let apiProd = "https://api.otmetka-x.ru/api/"
    // TODO: - Change https://api.otmetka-x.ru/api to https://api.otmetka-x.ru/api/dev
    static let apiDev = "https://api.otmetka-x.ru/api/"
}

enum ApiUrl {
    case api
    case daDataCleaner
    case daDataSuggestions
    

    var url: URL {
        switch self {
        case .api:
            return isProduction ? URL(string: ApiUrlConstants.apiProd)! : URL(string: ApiUrlConstants.apiDev)!
        case .daDataCleaner:
            return URL(string: "https://cleaner.dadata.ru/api/")!
        case .daDataSuggestions:
            return URL(string: "https://suggestions.dadata.ru/suggestions/api/")!
        }
    }
}

