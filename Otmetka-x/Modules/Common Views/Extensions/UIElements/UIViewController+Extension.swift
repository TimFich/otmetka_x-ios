//
//  UIViewController+Extension.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

// Inset tableview/collection view for tabbar
extension UIViewController {
    func insetScrollViewIfNeeded() {
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
        if let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView,
           let tabbar = navigationController?.tabBarController?.tabBar {
            scrollView.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: tabbar.frame.height,
                right: 0
            )
        }
    }
}

// Build and present system alert controller
extension UIViewController {
    func showSystemAlert(title: String,
                         description: String? = nil,
                         actionButtonTitle: String? = nil,
                         actionButtonTextColor: UIColor? = nil,
                         cancelButtonTitle: String? = nil,
                         cancelButtonTextColor: UIColor? = nil,
                         onAction: (() -> Void)? = nil,
                         onClose: (() -> Void)? = nil) {
        Task {
            await MainActor.run {
                let alertController = UIAlertController(title: title,
                                              message: description,
                                              preferredStyle: .alert)
                let mainAction = UIAlertAction(title: actionButtonTitle ?? R.string.localizable.commonButtonForward(),
                                               style: .default,
                                               handler: { _ in
                    guard let onAction = onAction else { return }
                    onAction()
                })
                let cancelAction = UIAlertAction(title: cancelButtonTitle ?? R.string.localizable.commonCancelActionButton(),
                                                 style: .default,
                                                 handler: { _ in
                    guard let onClose = onClose else { return }
                    onClose()
                })
                cancelAction.setValue(actionButtonTextColor ?? R.color.primary(), forKey: "titleTextColor")
                mainAction.setValue(cancelButtonTextColor ?? R.color.primary(), forKey: "titleTextColor")
                
                alertController.addAction(mainAction)
                alertController.addAction(cancelAction)
                alertController.preferredAction = cancelAction
                
                present(alertController, animated: true)
            }
        }
        
    }
}

