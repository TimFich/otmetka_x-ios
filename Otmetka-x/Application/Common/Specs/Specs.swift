//
//  Specs.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

class Specs {
    public static var link: Link { Link() }
    public static var font: Font { Font() }
    public static var constraints: Constraints { Constraints() }
}

// MARK: - Links

extension Specs {
    struct Link {
        
    }
}

// MARK: - Fonts

extension Specs {
    struct Font {
        /// size: 34
        /// style: BOLD
        let largeTitleBold: UIFont = .boldSystemFont(ofSize: 34)
        /// size: 28
        /// style: BOLD
        let title1Bold: UIFont = .systemFont(ofSize: 28, weight: .bold)
        /// size: 22
        /// style: BOLD
        let title2Bold: UIFont = .systemFont(ofSize: 22, weight: .bold)
        /// size: 17
        /// style: SEMIBOLD
        let bodyBold: UIFont = .systemFont(ofSize: 17, weight: .bold)
        /// size: 22
        /// style: SEMIBOLD
        let title2Semibold: UIFont = .systemFont(ofSize: 22, weight: .semibold)
        /// size: 20
        /// style: BOLD
        let bold: UIFont = .boldSystemFont(ofSize: 20)
        /// size: 20
        /// style: SEMIBOLD
        let title3Semibold: UIFont = .systemFont(ofSize: 20, weight: .semibold)
        /// size: 20
        /// style: REGULAR
        let title3: UIFont = .systemFont(ofSize: 20, weight: .regular)
        /// size: 17
        /// style: SEMIBOLD
        let bodySemibold17: UIFont = .systemFont(ofSize: 17, weight: .semibold)
        /// size: 17
        /// style: REGULAR
        let regular: UIFont = .systemFont(ofSize: 17, weight: .regular)
        /// title for advanced field in event
        /// - Parameters:
        ///   - size: 15
        ///   - style: SEMIBOLD
        let advancedFieldTitle: UIFont = .systemFont(ofSize: 15, weight: .semibold)
        /// size: 15
        /// style: REGULAR
        let subtitle15: UIFont = .systemFont(ofSize: 15, weight: .regular)
        /// title for advanced field in event AND(!) info field title
        /// - Parameters:
        ///   - size: 14
        ///   - style: REGULAR
        let plainFieldTitle: UIFont = .systemFont(ofSize: 14, weight: .regular)
        /// temp name for tags in events AND(!) expiration date label
        /// - Parameters:
        ///   - size: 12
        ///   - style: MEDIUM
        let tag: UIFont = .systemFont(ofSize: 12, weight: .medium)
        /// size: 12
        /// style: REGULAR
        let description: UIFont = .systemFont(ofSize: 12, weight: .regular)
        /// title for advanced field in event
        /// - Parameters:
        ///   - size: 10
        ///   - style: REGULAR
        let plainFieldSubtitle: UIFont = .systemFont(ofSize: 10, weight: .regular)
    }
}

extension Specs {
    struct Constraints {
        /// constraint: 4
        let extraSmallConstraint: CGFloat = CGFloat(4)
        /// constraint: 8
        let smallConstraint: CGFloat = CGFloat(8)
        /// constraint: 12
        let middiConstraint: CGFloat = CGFloat(12)
        /// constraint: 16
        let mediumConstraint: CGFloat = CGFloat(16)
        /// constraint: 24
        let largeConstraint: CGFloat = CGFloat(24)
        /// constraint: 32
        let extraLargeConstraint: CGFloat = CGFloat(32)
        /// constraint: 64
        let doubleExtraLargeConstraint: CGFloat = CGFloat(64)
        /// constraint: 0.5
        let halfConstraint: CGFloat = CGFloat(0.5)
    }
}
