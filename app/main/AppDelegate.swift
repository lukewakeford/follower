//
//  AppDelegate.swift
//  follower
//
//  Created by Luke Wakeford on 28/08/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = FMapViewController()
        let nav = FNavigationController(
            rootViewController: vc
        )
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

}
