//
//  AppDelegate.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/23/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import UIKit

// MARK: -   Global Property

    let cityForApp = "Atlanta"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = RootViewController.makeFromStoryboard()
        rootVC.current = SplashViewController.makeFromStoryboard()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
    
}

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
    
}

