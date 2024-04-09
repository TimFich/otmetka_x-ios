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

// MARK: - Eventable Module

protocol EventableProtocol {
    associatedtype EventType

    var receiver: (EventType) -> Void { get }
}

// TODOs: объединить в один AnyModule
typealias ModuleEventableFactoryResult<Input, Output, Event> = (
    module: AnyEventableModule<Input, Output, Event>,
    presentable: Presentable
)

protocol ModuleEventableProtocol: ModuleProtocol, EventableProtocol {}

final class AnyEventableModule<InputType, OutputType, EventType>: ModuleProtocol {
    private let setOutputClosure: (((OutputType) -> Void)?) -> Void
    private let getOutputClosure: () -> ((OutputType) -> Void)?
    private let getEventClosure: () -> ((EventType) -> Void)?

    init<T: ModuleEventableProtocol>(_ module: T) where T.InputType == InputType, T.OutputType == OutputType, T.EventType == EventType {
        getOutputClosure = { () -> ((OutputType) -> Void)? in
            module.output
        }
        setOutputClosure = { output in
            module.output = output
        }
        getEventClosure = { () -> ((EventType) -> Void)? in
            module.receiver
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

    var receiver: ((EventType) -> Void)? {
        getEventClosure()
    }
}
