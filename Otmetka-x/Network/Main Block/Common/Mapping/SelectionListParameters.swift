//
//  SelectionListParameters.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import Foundation
import Moya

struct SelectionListParameters: ApiParametersProtocol {
    var query: String
    
    func toDictionary() -> [String : Any] {
        ["query" : query, "count" : 20]
    }
}
