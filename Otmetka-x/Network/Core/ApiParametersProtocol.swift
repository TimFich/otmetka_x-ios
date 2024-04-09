//
//  ApiParametersProtocol.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import Foundation
import Moya

protocol ApiParametersProtocol {
    func toDictionary() -> [String: Any]
}

protocol ApiParametersMultipartFormDataProtocol: ApiParametersProtocol {
    func toMultipartFormData() -> [MultipartFormData]
}
