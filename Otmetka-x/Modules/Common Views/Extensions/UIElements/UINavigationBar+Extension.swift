//
//  UINavigationBar+Extension.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

extension UINavigationBar {
    func customizeForAuth() {
        setBackgroundImage(UIImage(), for: .default)
        isTranslucent = true
        shadowImage = UIImage()
        tintColor = .white
        barStyle = .black
        prefersLargeTitles = true
    }
    
    func customizeForMainPlainTitle() {
        tintColor = .primary
        prefersLargeTitles = false
    }
    
    func customizeForMain() {
        tintColor = .primary
        prefersLargeTitles = true
    }
}
