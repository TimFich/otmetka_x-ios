//
//  HTTPHeader.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 26.01.2024.
//

import Foundation

enum HTTPHeader {
    case bearerTokenHeader
    case os
    case appVersion
    case daDataToken
    case daDataSecretKey

    var key: String {
        switch self {
        case .bearerTokenHeader:
            return "Authorization"
        case .os:
            return "Operation-System"
        case .appVersion:
            return "App-Version"
        case .daDataToken:
            return "Authorization"
        case .daDataSecretKey:
            return "X-Secret"
        }
    }

    var value: String {
        switch self {
        case .bearerTokenHeader:
            return "Bearer \(token)"
        case .os:
            return "ios"
        case .appVersion:
            return App.appVersion
        case .daDataToken:
            return "Token 7da1ed7cc3a5c39d3c96f1129b7476d4ef185f02"
        case .daDataSecretKey:
            return "96fe638cb58f95c563e95be801e1dacef17a1ede"
        }
    }

    // Meta
    private var token: String {
        guard let token = UserSession.accessToken else {
            fatalError("token doesn't exist")
        }
        return token
    }
}


