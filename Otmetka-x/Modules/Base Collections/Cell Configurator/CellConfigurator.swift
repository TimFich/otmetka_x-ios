//
//  CellConfigurator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import UIKit

// MARK: - Config

protocol ContentConfigurator {
    func setup(with view: UIView)
}

struct CollectionConfigurator<ContentType: CellContentConfiguatorProtocol, ViewModel>: ContentConfigurator
    where ContentType.ViewModel == ViewModel, ContentType: UIView {
    private let item: ViewModel

    init(item: ViewModel) {
        self.item = item
    }

    func setup(with view: UIView) {
        if let view = view as? ContentType {
            view.setup(with: item)
        }
    }
}

// MARK: - Cell

protocol CellContentConfiguatorProtocol {
    associatedtype ViewModel
    func setup(with viewModel: ViewModel)
}

