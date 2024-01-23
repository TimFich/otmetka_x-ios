//
//  AppDelegate.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private(set) var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        DependencyStore.shared.registerAll()
        configureAppCoordinator()
        MainCoordinator.shared.start(withWindow: window)
        
        return true
    }
    
    private func configureAppCoordinator() {
        guard let window = window else { fatalError("Cannot get window in App Delegate") }
        appCoordinator = AppCoordinator(window: window)
    }
}

