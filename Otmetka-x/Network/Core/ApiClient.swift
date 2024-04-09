//
//  ApiClient.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import Foundation
import Moya

struct ApiClient: TargetType {
    var baseURL: URL = ApiUrl.api.url
    var path: String
    var method: Moya.Method
    var task: Task
    var headers: [String: String]?
    var validationType: ValidationType = .successAndRedirectCodes
    var sampleData = Data()

    init(baseURL: ApiUrl = .api,
         path: String,
         method: Moya.Method,
         task: HTTPEncoding,
         headers: [HTTPHeader]) {
        self.baseURL = baseURL.url
        self.path = path
        self.method = method
        self.task = task.task

        let finalHeaders: [HTTPHeader] = [.os, .appVersion] + headers
        self.headers = [:]
        finalHeaders.forEach {
            self.headers![$0.key] = $0.value
        }
    }
}
