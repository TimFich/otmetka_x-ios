//
//  BaseViewController.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

class BaseViewController: UIViewController {
    private let plugins: [BaseViewControllerPlugin]

    // MARK: - Initialization

    init(plugins: [BaseViewControllerPlugin] = []) {
        self.plugins = plugins
        super.init(nibName: nil, bundle: nil)
        setupAttributes()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        plugins.forEach { $0.onViewDidLoad() }

        setupAppearance()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        plugins.forEach { $0.onViewWillAppear(animated) }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        plugins.forEach { $0.onViewDidAppear(animated) }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        plugins.forEach { $0.onViewWillDisappear(animated) }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        plugins.forEach { $0.onViewDidDisappear(animated) }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        plugins.forEach { $0.onViewWillLayoutSubviews() }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        plugins.forEach { $0.onViewDidLayoutSubviews() }
    }

    // MARK: - Defined

    func setupAppearance() {
        layout()
        insetScrollViewIfNeeded()
    }

    func setup() {}
    func layout() {}
    func setupAttributes() {}
}

