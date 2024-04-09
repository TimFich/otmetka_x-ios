//
//  ViewModelState.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import Foundation

// MARK: - Table View

enum TableViewModelState {
    case initialized
    case loading
    case loaded(TableDataSource)
    case error(description: String)
}

enum TableViewUpdatableModelState {
    case initialized
    case loading
    case loaded(TableDataSource)
    case reloadSection(dataSource: TableDataSource, section: IndexSet)
    case error(description: String)
}

enum TableViewModelPaginationableState {
    case initialized
    case loading
    case loaded(TableDataSource)
    case addPage(TableDataSource, isLastPage: Bool)
    case error(description: String)
}

// MARK: - Collection View

enum CollectionViewModelState {
    case initialized
    case loading
    case loaded(CollectionDataSource)
    case error(description: String)
}

enum CollectionViewModelPaginationableState {
    case initialized
    case loading
    case loaded(CollectionDataSource)
    case addPage(CollectionDataSource, isLastPage: Bool)
    case error(description: String)
}
