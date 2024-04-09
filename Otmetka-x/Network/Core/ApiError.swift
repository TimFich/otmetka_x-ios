//
//  ApiError.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import Alamofire
import Foundation
import Moya
import Gloss

struct ApiError: LocalizedError {
    let code: ApiErrorStatusCode
    private let description: String

    var errorDescription: String {
        description
    }

    init(error: MoyaError) {
        code = ApiErrorStatusCode(rawInput: error.response?.statusCode)

        if let description = Self.mapDescription(from: error) {
            self.description = description
        } else {
            description = code.description
        }
    }

    init(errorText: String) {
        code = .unknown
        description = errorText
    }

    private static func mapDescription(from moyaError: MoyaError) -> String? {
        if let jsonResponse = try? moyaError.response?.mapJSON() as? JSON,
           let errors = jsonResponse["errors"] as? [JSON],
           let descriptions = errors.first?["error"] as? [String],
           let description = descriptions.first {
            return description
        } else {
            return nil
        }
    }
}

enum ApiErrorStatusCode: Int {
    case badRequest = 400
    case unauthorized = 401
    case internalServerError = 500
    case internetError
    case unknown

    var description: String {
        switch self {
        case .unauthorized:
            return R.string.localizable.errorAuthTokenError()
        case .internetError:
            return R.string.localizable.errorInternalError()
        case .badRequest,
             .internalServerError,
             .unknown:
            return R.string.localizable.errorUnknownError()
        }
    }

    init(rawInput: Int?) {
        if let rawValue = rawInput,
           let code = ApiErrorStatusCode(rawValue: rawValue) {
            self = code
        } else {
            self = .internetError
        }
    }
}

