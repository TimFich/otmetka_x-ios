//
//  InputCellViewModel.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import UIKit

struct InputTextCellViewModel {
    var type: TextFieldType
    var text: String?
    var didChangeValue: ((_ newValue: String) -> Void)?
    var maxCapacity: Int?
    var onTap: (() -> Void)?

    init(type: TextFieldType,
         text: String? = nil,
         maxCapacity: Int? = nil,
         onChangeValue: ((_ newValue: String) -> Void)? = nil,
         onTap: (() -> Void)? = nil) {
        self.type = type
        self.text = text
        didChangeValue = onChangeValue
        self.onTap = onTap
        self.maxCapacity = maxCapacity
    }
}

