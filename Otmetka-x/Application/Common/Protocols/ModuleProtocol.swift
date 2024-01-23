//
//  ModuleProtocol.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

protocol Presentable {
    var toPresent: UIViewController { get }
}

extension UIViewController: Presentable {
    var toPresent: UIViewController {
        self
    }
}

protocol ModuleProtocol: InOutableProtocol {}

typealias ModuleFactoryResult<Input, Output> = (
    module: AnyModule<Input, Output>,
    presentable: Presentable
)

final class AnyModule<InputType, OutputType>: ModuleProtocol {
    private let setOutputClosure: (((OutputType) -> Void)?) -> Void
    private let getOutputClosure: () -> ((OutputType) -> Void)?

    init<T: ModuleProtocol>(_ module: T) where T.InputType == InputType, T.OutputType == OutputType {
        getOutputClosure = { () -> ((OutputType) -> Void)? in
            module.output
        }

        setOutputClosure = { output in
            module.output = output
        }
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
