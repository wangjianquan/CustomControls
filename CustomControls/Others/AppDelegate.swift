//
//  AppDelegate.swift
//  CustomControls
//
//  Created by landixing on 2017/7/10.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit


let UM_TJ_Appkey = "5bf611e0f1f5560985000031"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        
//        UMTool.umSetUp()
        return true
    }
    
    func setupBugly() {
        let config = BuglyConfig()
        #if DEBUG
        config.debugMode = true
        #endif
        config.reportLogLevel = BuglyLogLevel.warn
        
        config.channel = "Bugly"
        
        Bugly.start(withAppId: "c9f7ff9896", config: config)
        
        Bugly.setTag(95418)
        
        Bugly.setUserIdentifier(UIDevice.current.name)
        
        Bugly.setUserValue(ProcessInfo.processInfo.processName, forKey: "Process")
        
        
        
        self.performSelector(inBackground: #selector(AppDelegate.logInBackground), with: nil)
    }
    
    @objc func logInBackground(){
        
        while(1 > 0) {
//            BLogError("Test %@", "Error")
//
//            BLogWarn("Test %@", "WARN")
            sleep(1)
        }
    }
//    public func BLogError(format: String, _ args: CVarArgType...){
//        BLYLogv(BuglyLogLevel.error, format, getVaList(args))
//
//    }
//
//    public func BLogWarn(format: String, _ args: CVarArgType...){
//        BLYLogv(BuglyLogLevel.warn, format, getVaList(args))
//    }
//
//    public func BLogInfo(format: String, _ args: CVarArgType...){
//        BLYLogv(BuglyLogLevel.info, format, getVaList(args))
//    }
//
//    public func BLogDebug(format: String, _ args: CVarArgType...){
//        BLYLogv(BuglyLogLevel.debug, format, getVaList(args))
//    }
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


