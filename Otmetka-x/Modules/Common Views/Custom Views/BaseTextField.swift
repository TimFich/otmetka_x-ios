//
//  BaseTextField.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 24.01.2024.
//

import UIKit

enum TextFieldType {
    case login
    case password
    case INN
    case OGRN
    case organizationName
    
    case buildingName
    case address
    case type
}

final class BaseTextField: UITextField, UITextFieldDelegate {

    var type: TextFieldType
    var onChangeValue: ((String) -> Void)?
    var maxCapacity: Int?
    var viewModelText: String?

    private let padding = UIEdgeInsets(top: Specs.constraints.smallConstraint,
                                       left: Specs.constraints.mediumConstraint,
                                       bottom: Specs.constraints.smallConstraint,
                                       right: Specs.constraints.mediumConstraint)
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height / 2
        }
    }

    init(type: TextFieldType,
                  text: String? = nil,
                  maxCapacity: Int? = nil,
                  onChangeValue: ((String) -> Void)? = nil) {
        self.type = type
        self.viewModelText = text
        self.onChangeValue = onChangeValue
        self.maxCapacity = maxCapacity
        super.init(frame: CGRect.zero)
        setup()
    }
    
    init() {
        self.type = .type
        super.init(frame: .zero)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        if let viewModelText = viewModelText {
            text = viewModelText
        }
        backgroundColor = .textFiledBackGround
        tintColor = .textFiledGray
        textColor = .black
        returnKeyType = .done
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        delegate = self

        switch type {
        case .login:
            attributedPlaceholder = NSAttributedString(string: R.string.localizable.registrationLoginPlaceholder(),
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFiledGray])
            autocorrectionType = .no
            autocapitalizationType = .none
        case .password:
            attributedPlaceholder = NSAttributedString(string: R.string.localizable.registrationPasswordPlaceholder(),
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFiledGray])
            isSecureTextEntry = true
        case .INN:
            attributedPlaceholder = NSAttributedString(string: R.string.localizable.registrationINNPlaceholder(),
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFiledGray])
            keyboardType = .numberPad
        case .OGRN:
            attributedPlaceholder = NSAttributedString(string: R.string.localizable.registrationOGRNPlaceholder(),
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFiledGray])
            keyboardType = .numberPad
        case .organizationName:
            attributedPlaceholder = NSAttributedString(string: R.string.localizable.registrationOrganizationNamePlaceholder(),
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFiledGray])
            autocapitalizationType = .words
            autocorrectionType = .no
        case .buildingName:
            attributedPlaceholder = NSAttributedString(string: R.string.localizable.buildingHubAddBuildingNamePlaceholder(),
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFiledGray])
            autocapitalizationType = .words
            autocorrectionType = .no
        case .address:
            attributedPlaceholder = NSAttributedString(string: R.string.localizable.buildingHubAddBuildingAddressPlaceholder(),
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFiledGray])
            
        case .type:
            attributedPlaceholder = NSAttributedString(string: R.string.localizable.buildingHubTypesUnowned(),
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFiledGray])
            textAlignment = .center
            tintColor = .clear
//            let picker = UIPickerView()
//            picker.delegate = self
//            picker.dataSource = self
//            inputView = picker
        }
    }

    // MARK: - Inset

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    // MARK: - Actions

    @objc func textFieldDidChange() {
        onChangeValue?(text ?? "")
    }

    // MARK: - Delegate Methods

    func textFieldShouldReturn(_: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, 
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text,
              let maxCapacity = maxCapacity
        else { return true }
        
        let maxLength = maxCapacity
        let currentString: NSString = NSString(string: text)
        let newString: NSString =  NSString(string: currentString.replacingCharacters(in: range, with: string))

        return newString.length <= maxLength
    }
}

extension BaseTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let array = BuildingTypes.allCases
        
        return NSAttributedString(string: array[row].description)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        BuildingTypes.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let array = BuildingTypes.allCases
        text = array[row].description
    }
}

