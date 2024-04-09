//
//  CollectionDataSource.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import UIKit

struct CollectionRow {
    let reuseIdentifier: String
    let config: ContentConfigurator
    let size: CGSize
    var onSelect = {}
    /// !!!!!!!WORKS ONLY WITH ChipsFilterCell
    var onSelectWithCell: (ChipsFilterCell) -> Void = { _ in }
    var onDeselect = {}
    var willDisplay = {}
    var endDisplay = {}
}

struct CollectionSectionView {
    let reuseIdentifier: String
    let size: CGSize = .zero
    let config: ContentConfigurator
}

struct CollectionSection {
    let header: CollectionSectionView?
    let footer: CollectionSectionView?
    var lineSpacing: CGFloat = 0
    var rows: [CollectionRow] = []

    mutating func add(row: CollectionRow) {
        rows.append(row)
    }

    mutating func add(rows: [CollectionRow]) {
        self.rows.append(contentsOf: rows)
    }
}

struct CollectionDataSource {
    var sections: [CollectionSection] = []

    mutating func add(section: CollectionSection) {
        sections.append(section)
    }

    mutating func add(sections: [CollectionSection]) {
        self.sections.append(contentsOf: sections)
    }

    func row(for indexPath: IndexPath) -> CollectionRow {
        sections[indexPath.section].rows[indexPath.row]
    }
}

