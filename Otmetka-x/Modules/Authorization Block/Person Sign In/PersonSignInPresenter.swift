//
//  PersonSignInPresenter.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 26.01.2024.
//

import Foundation

protocol PersonSignInPresenterProtocol: AnyObject {
    func setup()
    func doneButtonDidTap()
    
    // Interactor callbacks
    func needMoveToMainBlock(with token: String)
    func didCatchError(with text: String) 
}

final class PersonSignInPresenter: PersonSignInPresenterProtocol, ModuleProtocol {
    
    typealias InputType = PersonSignInModuleInput
    typealias OutputType = PersonSignInModuleOutput
    
    var output: ((OutputType) -> Void)?
    
    // Dependencies
    private weak var view: PersonSignInViewControllerDelegate?
    private let interactor: PersonSignInInteractorProtocol
    
    // Properties
    private var parameters: SignInParameters = SignInParameters()
    
    // MARK: - Initialization
    
    init(interactor: PersonSignInInteractorProtocol, view: PersonSignInViewControllerDelegate) {
        self.interactor = interactor
        self.view = view
    }
    
    // MARK: - Public
    
    func setup() {
        view?.update(with: .loading)
        makeViewModels()
    }
    
    func doneButtonDidTap() {
        guard validateParameters(),
              let newParameters = parameters.toParameters() else { return }
        
        view?.toggleButton(with: true)
        
        Task {
            await MainActor.run {
                interactor.signInPerson(parameter: newParameters)
            }
        }
    }
    
    func needMoveToMainBlock(with token: String) {
        Task {
            await MainActor.run {
                view?.toggleButton(with: false)
                output?(.needMoveToMainBlock(token))
            }
        }
    }
    
    func didCatchError(with text: String) {
        Task {
            await MainActor.run {
                view?.toggleButton(with: false)
                view?.didCatchError(with: text)
            }
        }
    }
    
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
        
        for viewModel in viewModels {
            let row = InputTextCell.makeCell(item: viewModel)
            sections.add(row)
        }
        dataSorce.add(sections)
        
        view?.update(with: .loaded(dataSorce))
    
    }
    
    private func validateParameters() -> Bool {
        if !(parameters.login?.isEmpty ?? true),
           !(parameters.password?.isEmpty ?? true) {
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
        default: break
        }
    }
}
