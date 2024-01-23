//
//  BaseViewControllerPlugin.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol BaseViewControllerPlugin {
    func onInit(controller: BaseViewController)
    func onViewDidLoad()
    func onViewWillAppear(_ animated: Bool)
    func onViewDidAppear(_ animated: Bool)
    func onViewWillDisappear(_ animated: Bool)
    func onViewDidDisappear(_ animated: Bool)
    func onViewWillLayoutSubviews()
    func onViewDidLayoutSubviews()
}

extension BaseViewControllerPlugin {
    func onInit(controller _: BaseViewController) {}
    func onViewDidLoad() {}
    func onViewWillAppear(_: Bool) {}
    func onViewDidAppear(_: Bool) {}
    func onViewWillDisappear(_: Bool) {}
    func onViewDidDisappear(_: Bool) {}
    func onViewWillLayoutSubviews() {}
    func onViewDidLayoutSubviews() {}
}

