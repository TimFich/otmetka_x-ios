//
//  Command.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import Foundation

public typealias Command = CommandWith<Void>

public struct CommandWith<T> {
    private var action: (T) -> Void

    public static var nop: CommandWith { CommandWith { _ in } }

    public init(action: @escaping (T) -> Void) {
        self.action = action
    }

    public func perform(with value: T) {
        action(value)
    }
}

public extension CommandWith where T == Void {
    func perform() {
        perform(with: ())
    }
}

public extension CommandWith {
    func bind(to value: T) -> Command {
        Command { self.perform(with: value) }
    }

    func map<U>(block: @escaping (U) -> T) -> CommandWith<U> {
        CommandWith<U> { self.perform(with: block($0)) }
    }
}

