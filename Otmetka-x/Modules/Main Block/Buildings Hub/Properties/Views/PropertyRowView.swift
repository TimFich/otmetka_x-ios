//
//  PropertyRowView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 04.03.2024.
//

import UIKit
import Kingfisher
import SnapKit

final class PropertyRowView: UIView {
    private enum Guidelines {
        static let remarkCounterContainterViewSize: CGSize = CGSize(width: 24, height: 24)
    }
    
    // UI
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = .zero
        return view
    }()
    
    private lazy var remarkCounterContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Guidelines.remarkCounterContainterViewSize.width,
                                        height: Guidelines.remarkCounterContainterViewSize.height))
        view.layer.cornerRadius = Guidelines.remarkCounterContainterViewSize.height / 2
        view.backgroundColor = .red
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor.red.cgColor
        return view
    }()
    
    private lazy var remarkCounterLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.bodyBold
        label.textAlignment = .left
        label.textColor = .systemBackground
        return label
    }()
    
    private let planImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.bodyBold
        label.textAlignment = .left
        label.textColor = .labelButton
        return label
    }()
    
    private lazy var floorLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.subtitle15
        label.textAlignment = .left
        label.textColor = .labelButton
        return label
    }()
    
    private lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.subtitle15
        label.textAlignment = .left
        label.textColor = .labelButton
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.advancedFieldTitle
        label.textAlignment = .left
        label.textColor = .labelButton
        label.numberOfLines = 3
        return label
    }()
    
    func setup(with viewModel: Property) {
        
        nameLabel.text = viewModel.name
        if let floor = viewModel.floor {
            floorLabel.text = R.string.localizable.buildingDetailedFloorPrefix(String(floor))
        }
        
        if let room = viewModel.room {
            roomLabel.text = R.string.localizable.buildingDetailedRoomPrefix(String(room))
        }
        
        authorLabel.text = R.string.localizable.buildingDetailedCreaterPrefix(viewModel.organization.login)
        layout()
        planImageView.kf.setImage(with: viewModel.image, placeholder: R.image.placeholder()!)
        remarkCounterLabel.text = "8"
    }
    
    private func layout() {
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(remarkCounterContainer)
        remarkCounterContainer.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(Specs.constraints.smallConstraint)
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        remarkCounterContainer.addSubview(remarkCounterLabel)
        remarkCounterLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        contentView.addSubview(planImageView)
        planImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(40)
            $0.size.equalTo(CGSize(width: 126, height: 126))
            $0.trailing.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.trailing.equalTo(planImageView.snp.leading).offset(-Specs.constraints.mediumConstraint)
        }
        
        contentView.addSubview(floorLabel)
        floorLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Specs.constraints.middiConstraint)
            $0.leading.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.trailing.equalTo(planImageView.snp.leading).offset(-Specs.constraints.mediumConstraint)
        }
        
        contentView.addSubview(roomLabel)
        roomLabel.snp.makeConstraints {
            $0.top.equalTo(floorLabel.snp.bottom).offset(Specs.constraints.extraSmallConstraint)
            $0.leading.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.trailing.equalTo(planImageView.snp.leading).offset(-Specs.constraints.mediumConstraint)
        }
        
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(roomLabel.snp.bottom).offset(Specs.constraints.largeConstraint)
            $0.leading.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.trailing.equalTo(planImageView.snp.leading).offset(-Specs.constraints.mediumConstraint)
            $0.bottom.lessThanOrEqualToSuperview().inset(Specs.constraints.mediumConstraint)
        }
    }
}
