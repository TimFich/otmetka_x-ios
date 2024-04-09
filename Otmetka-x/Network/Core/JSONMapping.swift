//
//  JSONMapping.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation
import os

protocol ApiModelToDomainProtocol: Codable {
    associatedtype DomainModelType

    func toDomain() -> DomainModelType
}

protocol JSONMapperProtocol {
    func parseResponse<ApiModel: ApiModelToDomainProtocol>(data: Data) throws -> ApiModel?
}

struct JSONMapper: JSONMapperProtocol {
    private static let logger = Logger(
                subsystem: Bundle.main.bundleIdentifier!,
                category: String(describing: JSONMapper.self)
            )
    
    func parseResponse<DTO: ApiModelToDomainProtocol>(data: Data) throws -> DTO? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let dto = try decoder.decode(DTO.self, from: data)
            return dto
        } catch {
            Self.logger.critical("Caught parsing error \(error)")
            return nil
        }
    }
}

