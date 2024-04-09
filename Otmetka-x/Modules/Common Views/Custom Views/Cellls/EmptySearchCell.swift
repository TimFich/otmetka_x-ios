//
//  EmptySearchCell.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import UIKit
import SnapKit

typealias EmptySearchTableViewCellConfig = CollectionConfigurator<EmptySearchTableViewCell, CGFloat>

final class EmptySearchTableViewCell: UITableViewCell, CellContentConfiguatorProtocol {
    enum Guidelines {
        static let sideConstraint: CGFloat = 56
    }
    
    typealias ViewModel = CGFloat
    
    // UI
    private lazy var emptySearchImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.emptySearch()!)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.bodyBold
        label.textColor = .labelButton
        label.textAlignment = .center
        label.text = R.string.localizable.commonEmptySearchTitle()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.regular
        label.textColor = .labelButton
        label.textAlignment = .center
        label.text = R.string.localizable.commonEmptySearchSubTitle()
        label.numberOfLines = 2
        return label
    }()
    
    
    func setup(with viewModel: ViewModel) {
        layout()
        selectionStyle = .none
    }
    
    private func layout() {
        contentView.addSubview(emptySearchImageView)
        emptySearchImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Guidelines.sideConstraint)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(emptySearchImageView.snp.bottom).offset(Specs.constraints.smallConstraint)
            $0.left.right.equalToSuperview().inset(Guidelines.sideConstraint)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Specs.constraints.smallConstraint)
            $0.left.right.equalToSuperview().inset(Guidelines.sideConstraint)
        }
    }
    
    static func makeCell(item: ViewModel) -> TableRow {
        TableRow(
            reuseIdentifier: identifier,
            config: EmptySearchTableViewCellConfig(item: item),
            height: item
        )
    }
}



