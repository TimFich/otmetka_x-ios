//
//  UIButton+Action.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 24.01.2024.
//

import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, overwrite: Bool, _ action: @escaping () -> Void) {
        if overwrite {
            removeTarget(nil, action: nil, for: controlEvents)
        }

        let action = ClosureAction(attachTo: self, closure: action)
        addTarget(action, action: ClosureAction.selector, for: controlEvents)
    }
}

extension UIButton {
    func onTouchUpInside(overwrite: Bool = true, _ action: @escaping () -> Void) {
        addAction(for: UIControl.Event.touchUpInside, overwrite: overwrite, action)
    }
}
