//
//  InputTextCell.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 24.01.2024.
//

import UIKit
import SnapKit

typealias InputTextCellConfig = CollectionConfigurator<InputTextCell, InputTextCellViewModel>

final class InputTextCell: UITableViewCell, CellContentConfiguatorProtocol {
   
    typealias ViewModel = InputTextCellViewModel
    
    var cellViewModel: ViewModel? {
        didSet {
            if let type = cellViewModel?.type {
                inputTextField.type = type
            }
            inputTextField.text = cellViewModel?.text
            inputTextField.isEnabled = cellViewModel?.onTap == nil
        }
    }
    
    private var inputTextField = BaseTextField()
    
    // UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Specs.font.regular
        label.textAlignment = .left
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if cellViewModel?.onTap != nil {
                cellViewModel?.onTap?()
            } else {
                if !inputTextField.isFirstResponder {
                    inputTextField.becomeFirstResponder()
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.removeFromSuperview()
        inputTextField.removeFromSuperview()
        cellViewModel = nil
    }
    
    func setup(with viewModel: ViewModel) {
        selectionStyle = .none
        self.cellViewModel = viewModel
        
        layout()
    }
    
    private func layout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
        
        setTitleText()
        
        inputTextField = BaseTextField(type: cellViewModel!.type,
                                       text: cellViewModel?.text,
                                       maxCapacity: cellViewModel?.maxCapacity,
                                       onChangeValue: cellViewModel?.didChangeValue)
        inputTextField.isEnabled = cellViewModel?.onTap == nil
        contentView.addSubview(inputTextField)
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Specs.constraints.extraSmallConstraint)
            $0.left.right.equalToSuperview().inset(Specs.constraints.mediumConstraint)
            $0.height.equalTo(Guidelines.textFiledHeight)
            $0.bottom.equalToSuperview().inset(Specs.constraints.mediumConstraint)
        }
    }
    
    private func setTitleText() {
        guard let type = cellViewModel?.type else { return }
        
        switch type {
        case .login:
            titleLabel.text = R.string.localizable.registrationLoginTextFieldTitle()
        case .password:
            titleLabel.text = R.string.localizable.registrationPasswordTextFieldTitle()
        case .INN:
            titleLabel.text = R.string.localizable.registrationINNTextFieldTitle()
        case .OGRN:
            titleLabel.text = R.string.localizable.registrationOGRNTextFieldTitle()
        case .organizationName:
            titleLabel.text = R.string.localizable.registrationOrganizationNameTextFieldTitle()
        case .buildingName:
            titleLabel.text = R.string.localizable.buildingHubAddBuildingNameTitle()
        case .address:
            titleLabel.text = R.string.localizable.buildingHubAddBuildingAddressPlaceholder()
        case .type:
            titleLabel.text = R.string.localizable.buildingHubAddBuildingTypeTitle()
        }
    }
}

extension InputTextCell {
    private enum Guidelines {
        static let textFiledHeight: CGFloat = CGFloat(40)
    }
}

extension InputTextCell {
    static func cellHeight(for _: ViewModel) -> CGFloat {
        UITableView.automaticDimension
    }
    
    static func makeCell(item: ViewModel) -> TableRow {
        TableRow(
            reuseIdentifier: identifier,
            config: InputTextCellConfig(item: item),
            height: cellHeight(for: item)
        )
    }
}

// MARK: - UITextFieldDelegate

extension InputTextCell: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}


