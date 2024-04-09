//
//  SignUpPresenter.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 24.01.2024.
//

import UIKit

protocol SignUpPresenterProtocol: AnyObject {
    func setUp()
    func doneButtonDidTap()
    
    // Interactor callbacks
    func needMoveToMainBlock(with token: String)
    func didCatchError(with text: String) 
}

final class SignUpPresenter: SignUpPresenterProtocol, ModuleProtocol {
    typealias InputType = SignUpModuleInput
    typealias OutputType = SignUpModuleOutput
    
    var output: ((OutputType) -> Void)?
    
    // Dependencies
    private let interactor: SignUpInteractorProtocol
    private weak var view: SignUpViewControllerDelegate?
    
    // Properties
    private var parameters: SignUpParameters = SignUpParameters()
    
    // MARK: - Initialization
    init(interactor: SignUpInteractorProtocol, view: SignUpViewControllerDelegate) {
        self.interactor = interactor
        self.view = view
    }
    
    // MARK: - Public
    
    func setUp() {
        view?.update(with: .loading)
        makeViewModels()
    }
    
    func doneButtonDidTap() {
        guard validateParameters(),
              let newParameter = parameters.toParameters() 
        else { return }
        view?.toggleButton(with: true)
        
        Task {
            await MainActor.run {
                interactor.signUpUser(parameter: newParameter)
            }
        }
    }
    
    func needMoveToMainBlock(with token: String) {
        Task {
            view?.toggleButton(with: false)
            output?(.needMoveToMainBlock(token))
        }
    }
    
    func didCatchError(with text: String) {
        Task {
            view?.didCatchError(with: text)
        }
    }
    
    // MARK: - Private
    
    private func makeViewModels() {
        var dataSorce = TableDataSource()
        var sections = TableSection()
        
        var viewModels: [InputTextCellViewModel] = []
        
        viewModels.append(.init(type: .login, onChangeValue: { [weak self] newValue in
            self?.changeParameter(newValue: newValue, type: .login)
        }))
        viewModels.append(.init(type: .password, onChangeValue: { [weak self] newValue in
            self?.changeParameter(newValue: newValue, type: .password)
        }))
        viewModels.append(.init(type: .INN,
                                maxCapacity: 10,
                                onChangeValue: { [weak self] newValue in
            self?.changeParameter(newValue: newValue, type: .INN)
        }))
        viewModels.append(.init(type: .OGRN,
                                maxCapacity: 13,
                                onChangeValue: { [weak self] newValue in
            self?.changeParameter(newValue: newValue, type: .OGRN)
        }))
        viewModels.append(.init(type: .organizationName, onChangeValue: { [weak self] newValue in
            self?.changeParameter(newValue: newValue, type: .organizationName)
        }))
        
        for viewModel in viewModels {
            let row = InputTextCell.makeCell(item: viewModel)
            sections.add(row)
        }
        dataSorce.add(sections)
        
        view?.update(with: .loaded(dataSorce))
    }
    
    private func validateParameters() -> Bool {
        if !(parameters.login?.isEmpty ?? true),
           !(parameters.password?.isEmpty ?? true),
           !(parameters.INN?.isEmpty ?? true),
           !(parameters.OGRN?.isEmpty ?? true),
           !(parameters.organizationName?.isEmpty ?? true) {
            return true
        }
        view?.didCatchError(with: R.string.localizable.errorAllFieldsNeedToFill())
        return false
    }
    
    private func changeParameter(newValue: String?, type: TextFieldType) {
            switch type {
            case .login:
                parameters.login = newValue
            case .password:
                parameters.password = newValue
            case .INN:
                parameters.INN = newValue
            case .OGRN:
                parameters.OGRN = newValue
            case .organizationName:
                parameters.organizationName = newValue
            default:
                break
            }
    }
}
