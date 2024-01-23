//
//  Injected.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

@propertyWrapper
class Injected<T> {
    private var storage: T?

    private let dependencyStore: DependencyStore

    init() {
        dependencyStore = DependencyStore.shared
    }

    var wrappedValue: T {
        if let storage = storage { return storage }
        let object: T = dependencyStore.resolve()
        storage = object
        return object
    }
}

