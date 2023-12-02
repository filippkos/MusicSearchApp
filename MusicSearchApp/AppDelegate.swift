//
//  AppDelegate.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 29.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    private var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.prepareRootController()
        
        return true
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareRootController() {
        let navigationController = UINavigationController()
        self.coordinator = AppCoordinator(navigationController: navigationController)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}

