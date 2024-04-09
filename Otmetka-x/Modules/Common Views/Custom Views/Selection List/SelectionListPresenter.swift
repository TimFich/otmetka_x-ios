//
//  SelectionListPresenter.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import UIKit

protocol SelectionListPresenterProtocol: AnyObject {
    func setup()
    func textDidChange(with text: String)
    
    // Interactor callback
    func fetchAddresses(with addresses: [Address])
    func didCatchError(with message: String)
    
}

final class SelectionListPresenter: ModuleProtocol, SelectionListPresenterProtocol {
    
    // MARK: - Module
    
    typealias InputType = SelectionListModuleInput
    typealias OutputType = SelectionListModuleOutput
    
    var output: ((OutputType) -> Void)?
    
    // Dependencies
    let interactor: SelectionListInteractorProtocol
    private weak var view: SelectionListViewDelegate?
    private let inputParam: SelectionListModuleInputData
    private var parameters: SelectionListParameters = SelectionListParameters(query: "")
    
    // Properties
    private var debouncer: DispatchWorkItem?
    
    // MARK: - Initialization
    
    init(interactor: SelectionListInteractorProtocol,
         view: SelectionListViewDelegate,
         input: SelectionListModuleInputData) {
        self.interactor = interactor
        self.view = view
        self.inputParam = input
    }
    
    func setup() {
        view?.update(with: .loaded(makeDataSource(with: [])))
    }
    
    func textDidChange(with text: String) {
        debouncer?.cancel()

        debouncer = DispatchWorkItem { [weak self] in
            guard let self = self,
                  !text.isEmpty else { return }
            self.view?.update(with: .loading)
            self.parameters.query = text
            self.interactor.fetchAddress(with: self.parameters)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: debouncer!)
    }
    
    func fetchAddresses(with addresses: [Address]) {
        Task { @MainActor in
            self.view?.update(with: .loaded(makeDataSource(with: addresses)))
        }
        
    }
    
    func didCatchError(with message: String) {
        Task { @MainActor in
            self.view?.update(with: .error(description: message))
        }
    }
    
    private func makeDataSource(with addresses: [Address]) -> TableDataSource {
        
        var dataSource = TableDataSource()
        var section = TableSection()
        
        if let height = view?.getSizeForPlaceholder(),
           addresses.isEmpty {
            let row = EmptySearchTableViewCell.makeCell(item: height)
            section.add(row)
        }
        
        for address in addresses {
            var row = TextCell.makeCell(item: address.name)
            row.onSelect = { [weak self] in
                self?.inputParam.onSelect.perform(with: address)
                self?.output?(.close)
            }
            section.add(row)
        }
        dataSource.add(section)
        return dataSource
    }
}
