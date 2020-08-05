//
//  AppDelegate.swift
//  DidYouKnow
//
//  Created by Rajasekhar on 05/08/20.
//  Copyright © 2020 Rajasekhar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = CountryViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        UINavigationBar.appearance().barTintColor = .defaultBlue
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

