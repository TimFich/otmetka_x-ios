//
//  BuildingCell.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 31.01.2024.
//

import UIKit
import SnapKit

typealias BuildingCellConfig = CollectionConfigurator<BuildingCell, BuildingCellViewModel>

final class BuildingCell: UITableViewCell, CellContentConfiguatorProtocol {
    typealias ViewModel = BuildingCellViewModel
    
    private var buildingRowView = BuildingRow()
    
    private var building: Building? {
        didSet {
            guard let building = building else { return }
            buildingRowView.setup(with: building)
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
        self.building = viewModel.building
    }
    
    // MARK: - Private

    private func setupAppearance() {
        selectionStyle = .none
        layout()
    }
    
    private func layout() {
        contentView.addSubview(buildingRowView)
        buildingRowView.snp.makeConstraints {
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
            config: BuildingCellConfig(item: item),
            height: cellHeight(for: item)
        )
    }
}
