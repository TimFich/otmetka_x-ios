//
//  UITabBarAppearance.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import UIKit

extension UITabBarAppearance {
    static var customized: UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .secondaryBackground
        appearance.compactInlineLayoutAppearance = .customized
        appearance.inlineLayoutAppearance = .customized
        appearance.stackedLayoutAppearance = .customized

        return appearance
    }
}

extension UITabBarItemAppearance {
    static var customized: UITabBarItemAppearance {
        let appearance = UITabBarItemAppearance()
        appearance.selected.iconColor = .white
        appearance.normal.iconColor = .white
        appearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        return appearance
    }
}

extension UITabBar {
// Fixes bug with tab bar appearance which came with iOS 15
    func fixAppearanceIfNeeded() {
        if #available(iOS 15.0, *) {
            standardAppearance = .customized
            scrollEdgeAppearance = .customized
        }
    }
}

