//
//  CoreTabBarController.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import UIKit

class CoreTabBarController: UITabBarController {
    
    let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 10.0
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.tintColor = .white
        tabBar.customizeForMain()
        tabBar.fixAppearanceIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomTabBarView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.3
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customTabBarView.frame = tabBar.frame
    }
    override func viewDidAppear(_ animated: Bool) {
        var newSafeArea = UIEdgeInsets()
        newSafeArea.bottom += customTabBarView.bounds.size.height
        self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
    }
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
}

class MainTabBarController:
    UITabBarController,
    UITabBarControllerDelegate {
    let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 10.0
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        addCustomTabBarView()
        hideTabBarBorder()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customTabBarView.frame = tabBar.frame
    }
    override func viewDidAppear(_ animated: Bool) {
        var newSafeArea = UIEdgeInsets()
        newSafeArea.bottom += customTabBarView.bounds.size.height
        self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
    }
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    func hideTabBarBorder()  {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    func setupTabBar(with controllers: [UIViewController]) {
        self.setViewControllers(controllers, animated: false)
        self.viewDidLayoutSubviews()
    }
}
extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

