//
//  BaseTableView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import UIKit

final class BaseTableView: UITableView {
    private var tableDataSource = TableDataSource()

    // Paginationable
    var onTriggerAddPage: Command?

    private var shouldLoadNextPage = false
    private lazy var bottomSpinnerManager = BottomSpinnerManager(scrollView: self, offsetToTriggerLoading: UIScreen.main.bounds.height * 3)

    var onScroll: () -> Void = {}

    func setup() {
        delegate = self
        dataSource = self
    }

    func update(dataSource: TableDataSource) {
        tableDataSource = dataSource
    }

    func toggleDidLoadAllPages(to didLoadAllPages: Bool) {
        bottomSpinnerManager.didLoadAllPages = didLoadAllPages
    }

    func hideInfinityScrollSpinner() {
        bottomSpinnerManager.hide()
    }
}

// MARK: - Data Source

extension BaseTableView: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        tableDataSource.sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = tableDataSource.sections[section]
        return section.rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableDataSource.row(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        row.config.setup(with: cell)
        return cell
    }
}

extension BaseTableView: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableDataSource.row(for: indexPath).height
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableDataSource.row(for: indexPath).onSelect()
    }

    func tableView(_: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableDataSource.row(for: indexPath).onDeselect()
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableDataSource.row(for: indexPath).willDisplay(cell, indexPath)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableDataSource.row(for: indexPath).onDelete(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        tableDataSource.row(for: indexPath).canEdit
    }

    func scrollViewDidScroll(_: UIScrollView) {
        if bottomSpinnerManager.shouldTriggerCommand() {
            onTriggerAddPage?.perform()
        }
        onScroll()
    }

    // MARK: - Headers/Footers

    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableDataSource.sections[section].header?.height ?? 0
    }

    func tableView(_: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        tableDataSource.sections[section].footer?.height ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = tableDataSource.sections[section]
        guard let headerViewId = section.header?.reuseIdentifier,
              let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewId) else {
            return nil
        }

        section.header?.config.setup(with: headerView)
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = tableDataSource.sections[section]
        guard let footerViewId = section.footer?.reuseIdentifier,
              let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerViewId) else {
            return nil
        }

        section.footer?.config.setup(with: footerView)
        return footerView
    }
}
