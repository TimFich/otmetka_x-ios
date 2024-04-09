//
//  ReusableCellProtocol.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import UIKit

protocol ReusableCellProtocol {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension ReusableCellProtocol {
    static var identifier: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}

extension UITableViewCell: ReusableCellProtocol {}
extension UICollectionViewCell: ReusableCellProtocol {}

