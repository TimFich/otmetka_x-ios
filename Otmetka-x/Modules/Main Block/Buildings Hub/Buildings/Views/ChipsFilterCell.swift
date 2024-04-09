//
//  ChipsFilterCell.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 31.01.2024.
//

import UIKit
import SnapKit

typealias ChipsFilterCellConfig = CollectionConfigurator<ChipsFilterCell, ChipsFilterCellViewModel>

final class ChipsFilterCell: UICollectionViewCell, CellContentConfiguatorProtocol {
    
    typealias ViewModel = ChipsFilterCellViewModel
    
    internal var counter: Int = 0
    
    // UI
    internal lazy var frontContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = .zero
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.plainFieldTitle
        label.textAlignment = .left
        label.textColor = .labelButton
        return label
    }()
    
    private lazy var iconImageView = UIImageView()
    
    // MARK: - Initialization
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    func setup(with viewModel: ViewModel) {
        switch viewModel.type {
        case .apartment:
            nameLabel.text = viewModel.type.shortDescription
            iconImageView.image = viewModel.type.image
        case .home:
            nameLabel.text = viewModel.type.shortDescription
            iconImageView.image = viewModel.type.image
        case .warehouse:
            nameLabel.text = viewModel.type.shortDescription
            iconImageView.image = viewModel.type.image
        case .unowned:
            nameLabel.text = viewModel.type.shortDescription
            iconImageView.image = viewModel.type.image
        }
        
        layout()
    }
    
    
    private func setupAppearance() {
        contentView.backgroundColor = .systemBackground
        layout()
    }
    
    private func layout() {
        contentView.addSubview(frontContentView)
        frontContentView.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.top.equalToSuperview().inset(Specs.constraints.smallConstraint)
            $0.left.right.equalToSuperview().inset(Specs.constraints.smallConstraint)
        }
        
        frontContentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24, height: 24))
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
        
        frontContentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(iconImageView.snp.right).offset(Specs.constraints.smallConstraint)
            $0.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
    }
    
    static func cellSize(with text: String) -> CGSize {
        CGSize(width: text.getSize(with: 15) + 80, height: 48)
    }
    
    static func makeCell(item: ViewModel) -> CollectionRow {
        CollectionRow(reuseIdentifier: identifier,
                      config: ChipsFilterCellConfig(item: item),
                      size: cellSize(with: item.type.shortDescription))
    }
}
