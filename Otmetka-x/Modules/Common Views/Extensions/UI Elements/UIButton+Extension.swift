//
//  UIButton+Extension.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 24.01.2024.
//

import UIKit

extension UIButton {
    @discardableResult
    func customizeWhite() -> Self {
        backgroundColor = .white
        layer.cornerRadius = 15
        setTitleColor(.black, for: .normal)
        return self
    }
    
    @discardableResult
    func customizePrimary(radius: CGFloat = 15) -> Self {
        backgroundColor = .primary
        layer.cornerRadius = radius
        setTitleColor(R.color.labelButton(), for: .normal)
        isUserInteractionEnabled(true)
        return self
    }
    
    @discardableResult
    func customizePrimaryDisabled(radius: CGFloat = 15) -> Self {
        backgroundColor = .lightGray
        layer.cornerRadius = radius
        setTitleColor(.gray, for: .normal)
        isUserInteractionEnabled(false)
        return self
    }
}
