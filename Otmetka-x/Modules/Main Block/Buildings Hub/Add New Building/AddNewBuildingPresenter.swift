//
//  AddNewBuildingPresenter.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.02.2024.
//

import Foundation

protocol AddNewBuildingPresenterProtocol: AnyObject {
    func setup()
    func closeButtonDidTap()
    func doneButtonDidTap()
    
    // Interactor callbacks
    func update(with flag: Bool)
    func didCatchError(with message: String)
}

final class AddNewBuildingPresenter: AddNewBuildingPresenterProtocol, ModuleProtocol {
    typealias InputType = AddNewBuildingModuleInput
    typealias OutputType = AddNewBuildingModuleOutput
    
    var output: ((OutputType) -> Void)?
    
    // Dependencies
    private weak var view: AddNewBuildingViewControllerDelegate?
    private let interactor: AddNewBuildingInteractorProtocol
    
    private var parameters: PreviewBuildingCellViewModel = PreviewBuildingCellViewModel()
    
    
    // MARK: - Initialization
    
    init(interactor: AddNewBuildingInteractorProtocol, view: AddNewBuildingViewControllerDelegate) {
        self.interactor = interactor
        self.view = view
    }
    
    // MARK: - Public
    
    func setup() {
        view?.update(with: .loading)
        makeDataSource(with: false)
    }
    
    func closeButtonDidTap() {
        output?(.close)
    }
    
    func doneButtonDidTap() {
        view?.toggleButton(with: true)
        guard let name = parameters.building.name,
              let address = parameters.building.address,
              let longitude = parameters.building.longitude,
              let latitude = parameters.building.latitude else {
            view?.update(with: .error(description: R.string.localizable.buildingHubAddBuildingError()))
            view?.toggleButton(with: false)
            return
        }
        
        interactor.addNewBuilding(
            parameters: .init(
                name: name,
                address: address,
                latitude: latitude,
                longitude: longitude
            )
        )
    }
    
    func update(with flag: Bool) {
        Task { @MainActor in
            if flag {
                output?(.doneButtonDidTap)
            } else {
                view?.update(with: .error(description: R.string.localizable.errorUnknownError()))
            }
        }
    }
    
    func didCatchError(with message: String) {
        Task { @MainActor in
            view?.update(with: .error(description: message))
        }
    }
    
    // MARK: - Private
    
    private func makeDataSource(with isReloaded: Bool) {
        var dataSorce = TableDataSource()
        
        var previewSection = TableSection()
        var previewRow = PreviewBuildingCell.makeCell(item: parameters)
        previewRow.canEdit = false
        previewSection.add(previewRow)
        dataSorce.add(previewSection)
        
        var inputSection = TableSection()
        
        var nameRow = InputTextCell.makeCell(item: .init(type: .buildingName,
                                                         text: parameters.building.name,
                                                         onChangeValue: { [weak self] newValue in
            self?.changeParameter(newValue: newValue, type: .buildingName)
        }))
        nameRow.canEdit = false
        inputSection.add(nameRow)
        
        var addressRow = InputTextCell.makeCell(item: .init(type: .address,
                                                            text: parameters.building.address,
                                                            onTap: { [weak self] in
            let input = SelectionListModuleInputData(selectionType: .address,
                                                     onSelect: CommandWith { selectedModel in
                if let selectedAddress = selectedModel as? Address {
                    self?.parameters.building.latitude = selectedAddress.latitude
                    self?.parameters.building.longitude = selectedAddress.longitude
                    self?.changeParameter(newValue: selectedAddress.name, type: .address)
                }})
            
            self?.output?(.showAddressSelection(input))
        }))
        addressRow.canEdit = false
        inputSection.add(addressRow)
        
//        var typeRow = InputTextCell.makeCell(item: .init(type: .type))
//        typeRow.canEdit = false
//        inputSection.add(typeRow)

        dataSorce.add(inputSection)
        
        if isReloaded {
            view?.update(with: .reloadSection(dataSource: dataSorce, 
                                              section: IndexSet(integer: 0)))
        } else {
            view?.update(with: .loaded(dataSorce))
        }
    }
    
    private func changeParameter(newValue: String, type: TextFieldType) {
        switch type {
        case .buildingName:
            parameters.building.name = newValue
            if newValue.isEmpty {
                parameters.building.name = R.string.localizable.buildingHubAddBuildingNamePlaceholder()
            }
            makeDataSource(with: true)
        case .address:
            parameters.building.address = newValue
            makeDataSource(with: false)
        case .type:
            parameters.building.type = .unowned
            makeDataSource(with: true)
        default:
            break
        }
    }
}


