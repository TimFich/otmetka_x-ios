//
//  HTTPEncoding.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 26.01.2024.
//

import Foundation
import Moya

enum HTTPEncoding {
    case urlEncoded(parameters: ApiParametersProtocol)
    case jsonEncoded(parameters: ApiParametersProtocol)
    case multipart(parameters: ApiParametersMultipartFormDataProtocol)
    case data(Data)
    case none

    var task: Task {
        switch self {
        case let .urlEncoded(parameters):
            return .requestParameters(parameters: parameters.toDictionary(), encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
        case let .jsonEncoded(parameters):
            return .requestParameters(parameters: parameters.toDictionary(), encoding: JSONEncoding.default)
        case let .multipart(parameters):
            return .uploadCompositeMultipart(parameters.toMultipartFormData(), urlParameters: parameters.toDictionary())
        case let .data(data):
            return .requestData(data)
        case .none:
            return .requestPlain
        }
    }
}

