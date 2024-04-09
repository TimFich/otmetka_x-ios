//
//  String+Extension.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 01.02.2024.
//

import UIKit

extension String {
    func getSize(with size: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: size)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}
