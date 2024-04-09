//
//  UITabBar+Extension.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import UIKit

extension UITabBar {
    func customizeForMain() {
        isTranslucent = false

        let bottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0

        let expandedRect = CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width,
            height: bounds.height + bottomInset
        )

        let path = UIBezierPath(
            roundedRect: expandedRect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(
                width: bounds.height / 2.8,
                height: bounds.height / 2.8
            )
        )

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
