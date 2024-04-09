//
//  PropertyCell.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import UIKit

struct PropertyCellViewModel {
    let property: Property
}

typealias PropertyCellConfig = CollectionConfigurator<PropertyCell, PropertyCellViewModel>

final class PropertyCell: UITableViewCell, CellContentConfiguatorProtocol {
    typealias ViewModel = PropertyCellViewModel
    
    private var propertyRowView = PropertyRowView()
    
    private var property: Property? {
        didSet {
            guard let property = property else { return }
            propertyRowView.setup(with: property)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    func setup(with viewModel: ViewModel) {
        self.property = viewModel.property
    }
    
    // MARK: - Private

    private func setupAppearance() {
        selectionStyle = .none
        layout()
    }
    
    private func layout() {
        contentView.addSubview(propertyRowView)
        propertyRowView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.top.bottom.equalToSuperview().inset(Specs.constraints.smallConstraint)
        }
    }
    
    static func cellHeight(for _: ViewModel) -> CGFloat {
        UITableView.automaticDimension
    }

    static func makeCell(item: ViewModel) -> TableRow {
        TableRow(
            reuseIdentifier: identifier,
            config: PropertyCellConfig(item: item),
            height: cellHeight(for: item)
        )
    }
}

