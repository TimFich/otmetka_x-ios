//
//  SelectionListModule.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import UIKit

enum SelectionType {
    case address
}

struct SelectionListModuleInputData {
    let selectionType: SelectionType
    let onSelect: CommandWith<SearchableModel>
}

typealias SelectionListModuleResult = ModuleFactoryResult<SelectionListModuleInput,
                                                          SelectionListModuleOutput>

extension ModulesBuilder {
    func selectionList(input: SelectionListModuleInputData) -> SelectionListModuleResult {
        SelectionListModule().configure(input: input)
    }
}

enum SelectionListModuleInput {}

enum SelectionListModuleOutput {
    case close
}

struct SelectionListModule {
    func configure(input: SelectionListModuleInputData) -> SelectionListModuleResult {
        let view = SelectionListViewController()
        let interactor = SelectionListInteractor()
        let presenter = SelectionListPresenter(interactor: interactor,
                                               view: view,
                                               input: input)
        interactor.presenter = presenter
        view.presenter = presenter

        return (AnyModule(presenter), view)
    }
}
