//
//  InOutableProtocol.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol InOutableProtocol: AnyObject {
    associatedtype InputType
    associatedtype OutputType

    var output: ((OutputType) -> Void)? { get set }
}
