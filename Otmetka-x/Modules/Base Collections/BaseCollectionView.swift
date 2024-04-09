//
//  BaseCollectionView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import UIKit

final class BaseCollectionView: UICollectionView {
    private var collectionDataSource = CollectionDataSource()

    // Paginationable
    var onTriggerAddPage: Command?

    private var shouldLoadNextPage = false
    private lazy var bottomSpinnerManager = BottomSpinnerManager(scrollView: self, offsetToTriggerLoading: UIScreen.main.bounds.height * 5)

    var onScroll: () -> Void = {}
    var onWillEndDragging: (CGPoint, UnsafeMutablePointer<CGPoint>) -> Void = { _, _ in }
    var onDidEndDecelerating: () -> Void = {}
    var onDidEndScrollingAnimation: () -> Void = {}

    func setup() {
        delegate = self
        dataSource = self
    }

    func update(dataSource: CollectionDataSource) {
        collectionDataSource = dataSource
    }

    func toggleDidLoadAllPages(to didLoadAllPages: Bool) {
        bottomSpinnerManager.didLoadAllPages = didLoadAllPages
    }

    func hideInfinityScrollSpinner() {
        bottomSpinnerManager.hide()
    }
}

// MARK: - Data Source

extension BaseCollectionView: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        collectionDataSource.sections.count
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionDataSource.sections[section].rows.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = collectionDataSource.row(for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.reuseIdentifier, for: indexPath)
        row.config.setup(with: cell)
        return cell
    }
}

// MARK: - Delegate

extension BaseCollectionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_: UIScrollView) {
        if bottomSpinnerManager.shouldTriggerCommand() {
            onTriggerAddPage?.perform()
        }
        onScroll()
    }

    func scrollViewWillEndDragging(_: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        onWillEndDragging(velocity, targetContentOffset)
    }

    func scrollViewDidEndDecelerating(_: UIScrollView) {
        onDidEndDecelerating()
    }

    func scrollViewDidEndScrollingAnimation(_: UIScrollView) {
        onDidEndScrollingAnimation()
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let section = collectionDataSource.sections[indexPath.section]

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let sectionHeaderId = section.header?.reuseIdentifier {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: sectionHeaderId,
                    for: indexPath
                )
                section.header?.config.setup(with: view)
                return view
            }
        case UICollectionView.elementKindSectionFooter:
            if let sectionFooterId = section.footer?.reuseIdentifier {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: sectionFooterId,
                    for: indexPath
                )
                section.footer?.config.setup(with: view)
                return view
            }
        default:
            break
        }

        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ChipsFilterCell {
            collectionDataSource.row(for: indexPath).onSelectWithCell(cell)
        }
        
        collectionDataSource.row(for: indexPath).onSelect()
    }

    func collectionView(_: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionDataSource.row(for: indexPath).onDeselect()
    }

    func collectionView(_: UICollectionView,
                        willDisplay _: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard indexPath.section < collectionDataSource.sections.count,
              indexPath.row < collectionDataSource.sections[indexPath.section].rows.count else {
            return
        }
        collectionDataSource.row(for: indexPath).willDisplay()
    }

    func collectionView(_: UICollectionView,
                        didEndDisplaying _: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard indexPath.section < collectionDataSource.sections.count,
              indexPath.row < collectionDataSource.sections[indexPath.section].rows.count else {
            return
        }
        collectionDataSource.row(for: indexPath).endDisplay()
    }
}

// MARK: - Flow Layout

extension BaseCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        collectionDataSource.sections[section].header?.size ?? .zero
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        collectionDataSource.sections[section].footer?.size ?? .zero
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionDataSource.sections[section].lineSpacing
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionDataSource.row(for: indexPath).size
    }
}

