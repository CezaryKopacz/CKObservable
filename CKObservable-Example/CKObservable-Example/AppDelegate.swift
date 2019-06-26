//
//  AppDelegate.swift
//  CKObservable-Example
//
//  Created by Cezary Kopacz on 24/06/2019.
//  Copyright © 2019 CezaryKopacz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {    
        let viewController = ViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        return true
    }
}

