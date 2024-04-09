//
//  BottomSpinerView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import UIKit

final class BottomSpinnerView: UIView {
    private let indicatorView = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        indicatorView.startAnimating()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
