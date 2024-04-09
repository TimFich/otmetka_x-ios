//
//  PropertyPresenter.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 01.02.2024.
//

import Foundation

protocol PropertyPresenterProtocol: AnyObject {
    func setup()
    func pullToRefresh()
    func didFetchProperties(with properties: [Property])
    func didCatchError(with message: String)
}

final class PropertyPresenter: PropertyPresenterProtocol, ModuleEventableProtocol {

    typealias InputType = PropertyModuleInput
    typealias OutputType = PropertyModuleOutput
    typealias EventType = PropertyModuleInputEvent

    var output: ((OutputType) -> Void)?
    
    lazy var receiver: (EventType) -> Void = bind()

    // Dependencies
    private weak var view: PropertyViewControllerDelegate?
    private let interactor: PropertyInteractorProtocol

    // Properties
    private let id: Int

    // MARK: - Initialization

    init(interactor: PropertyInteractorProtocol,
         view: PropertyViewControllerDelegate,
         id: Int) {
        self.interactor = interactor
        self.view = view
        self.id = id
    }

    func setup() {
        view?.update(with: .loading)
        Task { @MainActor in
            interactor.fetchProperties(with: id)
        }
    }

    func pullToRefresh() {
        setup()
    }

    func didFetchProperties(with properties: [Property]) {
        Task { @MainActor in
            self.view?.update(with: .loaded(makeDataSource(with: properties)))
        }
    }

    func didCatchError(with message: String) {
        view?.update(with: .error(description: message))
    }

    // MARK: - Private

    private func makeDataSource(with data: [Property]) -> TableDataSource {
        var dataSource = TableDataSource()
        var section = TableSection()
        
        for datum in data {
            var row = PropertyCell.makeCell(item: .init(property: datum))
            row.onSelect = { [weak self] in
                self?.output?(.showDetailed(datum.id))
            }
            
            section.add(row)
        }
        dataSource.add(section)
        return dataSource
    }

    private func makeViewModels() {
        
    }
    
    private func bind() -> ((EventType) -> Void) {
        { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .reloadData:
                self.setup()
            }
        }
    }
}
