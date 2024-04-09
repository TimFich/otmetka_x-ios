//
//  BottomSpinerManager.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 25.01.2024.
//

import UIKit

final class BottomSpinnerManager {
    enum Guidelines {
        static let spinnerHeight: CGFloat = 50
    }

    // Views
    private var spinnerView: BottomSpinnerView?
    private weak var scrollView: UIScrollView?
    private var strongScrollView: UIScrollView {
        guard let scrollView = scrollView else { fatalError("ScrollView is lost") }
        return scrollView
    }

    // Settings
    var didLoadAllPages = true
    private let offsetToTriggerLoading: CGFloat
    private var isLoading = false

    init(scrollView: UIScrollView,
         offsetToTriggerLoading: CGFloat) {
        self.scrollView = scrollView
        self.offsetToTriggerLoading = offsetToTriggerLoading
    }

    func shouldTriggerCommand() -> Bool {
        if !didLoadAllPages,
           !isLoading,
           strongScrollView.contentOffset.y > 0,
           strongScrollView.contentOffset.y > strongScrollView.contentSize.height - offsetToTriggerLoading,
           spinnerView == nil {
            isLoading = true
            spinnerView = makeBottomSpinner()
            strongScrollView.addSubview(spinnerView!)
            strongScrollView.contentInset.bottom += Guidelines.spinnerHeight
            return true
        }
        return false
    }

    func hide() {
        isLoading = false
        scrollView?.contentInset.bottom -= Guidelines.spinnerHeight
        spinnerView?.removeFromSuperview()
        spinnerView = nil
    }

    private func makeBottomSpinner() -> BottomSpinnerView {
        BottomSpinnerView(frame: CGRect(
            x: 0,
            y: strongScrollView.contentSize.height,
            width: strongScrollView.bounds.width,
            height: Guidelines.spinnerHeight
        ))
    }
}
