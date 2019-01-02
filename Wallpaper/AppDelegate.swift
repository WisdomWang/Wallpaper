//
//  AppDelegate.swift
//  Wallpaper
//
//  Created by Cary on 2018/12/18.
//  Copyright © 2018 Cary. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainVC  =  ViewController()
        let pcVC = PCViewController()
        let mainNav = UINavigationController(rootViewController: mainVC)
        let pcNav = UINavigationController(rootViewController: pcVC)
        mainNav.tabBarItem = UITabBarItem(title: "主页", image: UIImage(named: "dis_tabbar_normal"), selectedImage: UIImage(named: "dis_tabbar_selected"))
        pcNav.tabBarItem =  UITabBarItem(title: "我的", image: UIImage(named: "pc_tabbar_normal"), selectedImage: UIImage(named: "pc_tabbar_selected"))
        
        let tabbar = UITabBarController()
        tabbar.tabBar.tintColor = UIColor.red
        tabbar.viewControllers = [mainNav,pcNav]
        
        window?.backgroundColor = UIColor.white
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

