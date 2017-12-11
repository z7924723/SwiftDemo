//
//  AppDelegate.swift
//  BottomNavigation
//
//  Created by PinguMac on 2017/12/11.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window!.backgroundColor = UIColor.white
    self.window?.rootViewController = setTabbar()
    self.window?.makeKeyAndVisible()

    return true
  }

  func setTabbar() -> UITabBarController {
    let tabbarcntrl = UITabBarController()
    
    let homeVC = HomePageVC()
    let dashboardVC = DashboardVC()
    let notifyVC = NotifyVC()
    
    let nvHome = UINavigationController(rootViewController: homeVC)
    nvHome.navigationBar.barTintColor = UIColor.lightGray
    
    tabbarcntrl.viewControllers = [nvHome, dashboardVC, notifyVC]

    let tabHome = tabbarcntrl.tabBar.items![0]
//    tabHome.title = "Home"
    tabHome.image = UIImage(named: "home_unselect")?.withRenderingMode(.alwaysOriginal)
    tabHome.selectedImage = UIImage(named: "home_select")?.withRenderingMode(.alwaysOriginal)
//    tabHome.titlePositionAdjustment.vertical = tabHome.titlePositionAdjustment.vertical-4 // title position change
    
    let tabDashboard = tabbarcntrl.tabBar.items![1]
//    tabDashboard.title = "Dashboard"
    tabDashboard.image=UIImage(named: "dashboard")?.withRenderingMode(.alwaysOriginal)
    tabDashboard.selectedImage=UIImage(named: "dashboard")?.withRenderingMode(.alwaysOriginal)
//    tabDashboard.titlePositionAdjustment.vertical = tabDashboard.titlePositionAdjustment.vertical - 4
    
    let tabNotify = tabbarcntrl.tabBar.items![2]
//    tabNotify.title = "Notify"
    tabNotify.image=UIImage(named: "notify_unselect")?.withRenderingMode(.alwaysOriginal)
    tabNotify.selectedImage=UIImage(named: "notify_select")?.withRenderingMode(.alwaysOriginal)
//    tabNotify.titlePositionAdjustment.vertical = tabNotify.titlePositionAdjustment.vertical - 4
    
    return tabbarcntrl
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

