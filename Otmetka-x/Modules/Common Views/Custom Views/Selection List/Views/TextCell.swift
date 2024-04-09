//
//  TextCell.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import UIKit
import SnapKit

typealias TextCellConfig = CollectionConfigurator<TextCell, String>

final class TextCell: UITableViewCell, CellContentConfiguatorProtocol {
    typealias ViewModel = String
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.subtitle15
        label.textColor = .labelButton
        label.numberOfLines = 0
        return label
    }()
    
    func setup(with viewModel: String) {
        titleLabel.text = viewModel
        layout()
    }
    
    private func layout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.top.bottom.equalToSuperview().inset(Specs.constraints.smallConstraint)
        }
    }
    
    static func cellHeight() -> CGFloat { UITableView.automaticDimension }
    
    static func makeCell(item: ViewModel) -> TableRow {
        TableRow(reuseIdentifier: identifier,
                 config: TextCellConfig(item: item),
                 height: cellHeight())
    }
}
