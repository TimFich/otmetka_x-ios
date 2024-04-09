//
//  BuildingsHubPresenter.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

protocol BuildingsHubPresenterProtocol: AnyObject {
    func setup()
    func pullToRefresh()
    func loadMore()
    func addButtonDidTap()
    
    // Interactor callbacks
    func buildingsDidFetched(with buildings: [Building])
    func didCatchErorr(with message: String)
    func needToShowWarning()
}

final class BuildingsHubPresenter: BuildingsHubPresenterProtocol, ModuleProtocol {
    typealias InputType = BuildingsHubModuleInput
    typealias OutputType = BuildingsHubModuleOutput
    
    var output: ((OutputType) -> Void)?
    
    // Dependencies
    private weak var view: BuildingsHubViewControllerDelegate?
    private let interactor: BuildingsHubInteractorProtocol
    
    // Properties
    private var items: [Building] = []
    private var filteredItems: [Building] = []
    private var selectedFilters: Set<BuildingTypes> = []
    private var dataSource: TableDataSource = TableDataSource()
    
    // MARK: - Initialization
    
    init(interactor: BuildingsHubInteractorProtocol, view: BuildingsHubViewControllerDelegate) {
        self.interactor = interactor
        self.view = view
    }
    
    // MARK: - Public
    
    func setup() {
        view?.updateTableView(with: .loading)
        Task {
            interactor.fetchBuildings()
        }
    }
    
    func pullToRefresh() {
        setup()
    }
    
    func loadMore() {
        
    }
    
    func buildingsDidFetched(with buildings: [Building]) {
        Task {
            await MainActor.run {
//                self.items = buildings
//                self.filteredItems = buildings
                
                
                let viewModels = makeViewModels(from: buildings)
                self.dataSource = makeTableDataSource(from: viewModels)
                view?.updateTableView(with: .loaded(dataSource))
            }
        }
    }
    
    func didCatchErorr(with message: String) {
        view?.updateTableView(with: .error(description: message))
    }
    
    func addButtonDidTap() {
        output?(.addButtonDidTap)
    }
    
    func needToShowWarning() {
        view?.showInternetWarning()
    }
    
    private func makeViewModels(from items: [Building]) -> [BuildingCellViewModel] {
        var viewModels: [BuildingCellViewModel] = []
        
        for item in items {
            viewModels.append(.init(building: item))
        }
        return viewModels
    }
    
    private func makeTableDataSource(from viewModels: [BuildingCellViewModel]) -> TableDataSource {
        var dataSource = TableDataSource()
        var section = TableSection()
        
        var filterSection = TableSection()
        filterSection.add(makeFilterRow())
        dataSource.add(filterSection)
        
        for viewModel in viewModels {
            var row = BuildingCell.makeCell(item: viewModel)
            row.onSelect = { [weak self] in
                self?.output?(.moveToBuildingDetailed(viewModel.building.id))
            }
            row.onDelete = { [weak self] indexPath in
                self?.deleteCell(with: indexPath)
            }
            section.add(row)
        }
        dataSource.add(section)
        
        return dataSource
    }
    
    private func deleteCell(with indexPath: IndexPath) {
        dataSource.removeRow(for: indexPath)
        view?.updateTableView(with: .loaded(dataSource))
    }
    
    // MARK: - NOW Unused(Block: Filter rows fix)
    
    func makeFilterRow() -> TableRow {
        let viewModels: BuildingsFilterCellViewModel = 
            .init(filters: [
                .init(type: .apartment),
                .init(type: .home),
                .init(type: .warehouse),
                .init(type: .unowned)],
                  onSelect: CommandWith { type in
                self.filterDidTap(with: type)
            }
            )
        
        var row = BuildingsFilterCell.makeCell(item: viewModels)
        row.canEdit = false
        return row
    }
    
    private func filterDidTap(with type: BuildingTypes) {
        if selectedFilters.contains(type) {
            selectedFilters.remove(type)
            guard !selectedFilters.isEmpty else {
                filteredItems = items
                let viewModels = makeViewModels(from: filteredItems)
                view?.updateTableView(with: .loaded(makeTableDataSource(from: viewModels)))
                return
            }
            self.filteredItems = filterElements(by: Array(selectedFilters), from: self.items)
        } else {
            selectedFilters.insert(type)
            self.filteredItems = filterElements(by: Array(selectedFilters), from: self.filteredItems)
        }
        
        let viewModels = makeViewModels(from: filteredItems)
        view?.updateTableView(with: .loaded(makeTableDataSource(from: viewModels)))
    }
    
    
    private func filterElements(by types: [BuildingTypes], from items: [Building]) -> [Building] {
        items.filter {
            types.contains($0.type)
        }
    }
}
