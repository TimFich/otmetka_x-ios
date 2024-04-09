//
//  UIView+Extension.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 24.01.2024.
//

import UIKit

extension UIView {
    @discardableResult
    func isUserInteractionEnabled(_ newValue: Bool) -> Self {
        isUserInteractionEnabled = newValue
        return self
    }
}
