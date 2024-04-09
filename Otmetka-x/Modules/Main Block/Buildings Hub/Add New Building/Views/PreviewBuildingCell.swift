//
//  PreviewBuildingCell.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 02.03.2024.
//

import UIKit
import SnapKit

typealias PreviewBuildingCellConfig = CollectionConfigurator<PreviewBuildingCell, PreviewBuildingCellViewModel>

final class PreviewBuildingCell: UITableViewCell, CellContentConfiguatorProtocol {
    
    typealias ViewModel = PreviewBuildingCellViewModel
    
    // UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.regular
        label.textColor = .labelButton
        label.text = R.string.localizable.buildingHubAddBuildingPreviewTitle()
        return label
    }()
    
    private var buildingRow = BuildingRow()
    
    private var building: Building? {
        didSet {
            guard let building = building else { return }
            buildingRow.setup(with: building)
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Specs.constraints.largeConstraint)
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
        
        contentView.addSubview(buildingRow)
        buildingRow.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Specs.constraints.mediumConstraint)
            $0.left.right.bottom.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
    }
    
    
    static func cellHeight() -> CGFloat { UITableView.automaticDimension }
    
    static func makeCell(item: ViewModel) -> TableRow {
        TableRow(reuseIdentifier: identifier,
                 config: PreviewBuildingCellConfig(item: item),
                 height: cellHeight())
    }
}
