//
//  BuildingRow.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 03.03.2024.
//

import UIKit

final class BuildingRow: UIView {
    private enum Guidelines {
        static let shevronSize: CGSize = CGSize(width: 24, height: 24)
        static let typeOfBuildingViewSize: CGSize = CGSize(width: 48, height: 48)
    }
    
    // UI
    private lazy var frontContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = .zero
        return view
    }()

    private lazy var imageViewContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Guidelines.typeOfBuildingViewSize.width,
                                        height: Guidelines.typeOfBuildingViewSize.height))
        view.backgroundColor = .primary
        view.layer.cornerRadius = Guidelines.typeOfBuildingViewSize.height / 2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.labelButton.cgColor
        return view
    }()

    private let typeOfBuildingImageView = UIImageView()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.bodyBold
        label.textAlignment = .left
        label.textColor = .labelButton
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = Specs.font.description
        label.textAlignment = .left
        label.textColor = .labelButton
        return label
    }()
    
    private lazy var typeOfBuildingLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.description
        label.textAlignment = .left
        label.textColor = .labelButton
        return label
    }()
    
    private lazy var shevronImageView: UIImageView = {
        let image = UIImageView(image: R.image.shevronRight()!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    func setup(with viewModel: Building) {
        titleLabel.text = viewModel.name
        addressLabel.text = R.string.localizable.buildingHubCellAddress(viewModel.address ?? "")
        typeOfBuildingLabel.text = R.string.localizable.buildingHubCellTypeOfBuilding(viewModel.type.description)
        typeOfBuildingImageView.image = viewModel.type.image
        layout()
    }
    
    private func layout() {
        addSubview(frontContentView)
        frontContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        frontContentView.addSubview(imageViewContainer)
        imageViewContainer.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.size.equalTo(CGSize(width: 48, height: 48))
        }
        
        imageViewContainer.addSubview(typeOfBuildingImageView)
        typeOfBuildingImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24, height: 24))
            $0.centerX.centerY.equalToSuperview()
        }
        
        frontContentView.addSubview(shevronImageView)
        shevronImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Specs.constraints.smallConstraint)
            $0.size.equalTo(Guidelines.shevronSize)
        }
        
        frontContentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.leading.equalTo(imageViewContainer.snp.trailing).offset(Specs.constraints.smallConstraint)
            $0.trailing.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
        
        
        
        frontContentView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Specs.constraints.smallConstraint)
            $0.leading.equalTo(imageViewContainer.snp.trailing).offset(Specs.constraints.smallConstraint)
            $0.trailing.equalTo(shevronImageView.snp.leading).offset(-Specs.constraints.smallConstraint)
        }
        
        frontContentView.addSubview(typeOfBuildingLabel)
        typeOfBuildingLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(Specs.constraints.smallConstraint)
            $0.leading.equalTo(imageViewContainer.snp.trailing).offset(Specs.constraints.smallConstraint)
            $0.trailing.equalTo(shevronImageView.snp.leading).inset(-Specs.constraints.smallConstraint)
            $0.bottom.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
    }
}
