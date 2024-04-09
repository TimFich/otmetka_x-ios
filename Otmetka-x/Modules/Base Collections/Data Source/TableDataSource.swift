//
//  TableDataSource.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import UIKit

struct TableRow {
    let reuseIdentifier: String
    let config: ContentConfigurator
    let height: CGFloat

    var onSelect = {}
    var onDeselect = {}
    var canEdit: Bool = true
    var onDelete: (IndexPath) -> Void = { indexPath in }
    var willDisplay: (UITableViewCell, IndexPath) -> Void = { _, _ in }
    var didEndDisplay: (UITableView, UITableViewCell, IndexPath) -> Void = { _, _, _ in }
}

struct TableSectionView {
    let reuseIdentifier: String
    let height: CGFloat
    let config: ContentConfigurator
}

struct TableSection {
    var header: TableSectionView?
    var footer: TableSectionView?
    var rows: [TableRow] = []

    mutating func add(_ row: TableRow) {
        rows.append(row)
    }

    mutating func add(_ rows: [TableRow]) {
        self.rows.append(contentsOf: rows)
    }
}

struct TableDataSource {
    var sections: [TableSection] = []

    mutating func add(_ section: TableSection) {
        sections.append(section)
    }

    mutating func add(_ sections: [TableSection]) {
        self.sections.append(contentsOf: sections)
    }

    func row(for indexPath: IndexPath) -> TableRow {
        sections[indexPath.section].rows[indexPath.row]
    }
    
    mutating func removeRow(for indexPath: IndexPath) {
        sections[indexPath.section].rows.remove(at: indexPath.row)
    }
}

