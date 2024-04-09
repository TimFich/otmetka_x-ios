//
//  LoadingableButton.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import UIKit

class LoadingableButton: UIButton {
    private enum ButtonTitle {
        case string(String)
        case attributedString(NSAttributedString)
        case empty
    }

    private var storedTitle: ButtonTitle = .empty
    private var isLoading: Bool = false

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = self.titleColor(for: .normal)
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([xCenterConstraint, yCenterConstraint])
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        storedTitle = .string(title ?? "")
    }

    override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        super.setAttributedTitle(title, for: state)
        storedTitle = .attributedString(title ?? NSAttributedString())
    }

    func toggleLoading(isLoading: Bool) {
        Task {
            await MainActor.run {
                guard self.isLoading != isLoading else { return }

                // state
                self.isLoading = isLoading
                isEnabled = !isLoading

                if isLoading {
                    clearTitle()
                    activityIndicator.startAnimating()
                } else {
                    restoreTitle()
                    activityIndicator.stopAnimating()
                }
            }
        }
    }

    // TODO: here
    private func clearTitle() {
        super.setTitle("", for: .normal)
        super.setAttributedTitle(NSAttributedString(), for: .normal)
    }

    private func restoreTitle() {
        switch storedTitle {
        case let .string(string):
            super.setTitle(string, for: .normal)
        case let .attributedString(attributedString):
            super.setAttributedTitle(attributedString, for: .normal)
        case .empty: break
        }
    }
}

