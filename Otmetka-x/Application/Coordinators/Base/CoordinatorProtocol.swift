//
//  CoordinatorProtocol.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol CoordinatorProtocol: InOutableProtocol {
    func start(with option: InputType)
}

typealias CoordinatorFactoryResult<Input, Output> = (
    coordinator: AnyCoordinator<Input, Output>,
    presentable: Presentable
)

class AnyCoordinator<InputType, OutputType>: CoordinatorProtocol {
    private let setOutputClosure: (((OutputType) -> Void)?) -> Void
    private let getOutputClosure: () -> ((OutputType) -> Void)?
    private let startClosure: (InputType) -> Void

    init<T: CoordinatorProtocol>(_ coordinator: T) where T.InputType == InputType, T.OutputType == OutputType {
        startClosure = { option in
            coordinator.start(with: option)
        }

        getOutputClosure = { () -> ((OutputType) -> Void)? in
            coordinator.output
        }

        setOutputClosure = { output in
            coordinator.output = output
        }
    }

    func start(with option: InputType) {
        startClosure(option)
    }

    var output: ((OutputType) -> Void)? {
        get {
            getOutputClosure()
        }

        set {
            setOutputClosure(newValue)
        }
    }
}

