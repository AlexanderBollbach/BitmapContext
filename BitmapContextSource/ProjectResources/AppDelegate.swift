//
//  AppDelegate.swift
//  bitmapTest
//
//  Created by Bollbach, Alexander on 4/24/18.
//  Copyright © 2018 Bollbach, Alexander. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = DemoViewController(nibName: nil, bundle: nil)
        window?.makeKeyAndVisible()
        
        return true
    }
}

