//
//  Navigator.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

typealias NavigatorCompletion = () -> Void

protocol NavigatorProtocol: Presentable {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, animated: Bool, completion: NavigatorCompletion?)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)

    func popModule()
    func popModule(animated: Bool)

    func dismissModule()
    func dismissModule(animated: Bool, completion: NavigatorCompletion?)

    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)

    func popToRootModule(animated: Bool)

    var onPopped: () -> Void { get set }
    var onPushed: () -> Void { get set }

    var modulesInAStack: Int { get }
}

class Navigator: NSObject {
    var toPresent: UIViewController {
        rootController
    }

    var onPopped: () -> Void = {}
    var onPushed: () -> Void = {}

    var modulesInAStack: Int {
        let presentedCounter = rootController.presentedViewController != nil ? 1 : 0
        return rootController.viewControllers.count + presentedCounter
    }

    private(set) var rootController: UINavigationController!

    private var viewControllersCount = 0

    init(navController: UINavigationController) {
        rootController = navController
        super.init()
        rootController.delegate = self
    }
}

extension Navigator: NavigatorProtocol {
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    func present(_ module: Presentable?, animated: Bool) {
        present(module, animated: animated, completion: nil)
    }

    func present(_ module: Presentable?, animated: Bool, completion: NavigatorCompletion?) {
        guard let controller = module?.toPresent else { return }
        rootController.present(controller, animated: animated, completion: completion)
    }

    func push(_ module: Presentable?) {
        push(module, animated: true)
    }

    func push(_ module: Presentable?, animated: Bool) {
        guard
            let controller = module?.toPresent,
            !(controller is UINavigationController)
        else { assertionFailure("⚠️ Deprecated push UINavigationController."); return }
        rootController.pushViewController(controller, animated: animated)
    }

    func popModule() {
        popModule(animated: true)
    }

    func popModule(animated: Bool) {
        rootController.popViewController(animated: animated)
    }

    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: NavigatorCompletion?) {
        rootController.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController.setViewControllers([controller], animated: false)
        rootController.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        rootController.popToRootViewController(animated: animated)
    }
}

extension Navigator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow _: UIViewController, animated _: Bool) {
        let newViewControllersCount = navigationController.viewControllers.count

        if newViewControllersCount > viewControllersCount {
            onPushed()
        } else if newViewControllersCount < viewControllersCount {
            onPopped()
        }

        viewControllersCount = newViewControllersCount
    }
}
