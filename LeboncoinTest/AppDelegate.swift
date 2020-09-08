//
//  AppDelegate.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 02/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = AdsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let container = UINavigationController(rootViewController: root)
        window?.rootViewController = container
        window?.makeKeyAndVisible()
        return true
    }

}

