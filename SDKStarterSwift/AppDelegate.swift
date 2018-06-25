//
//  AppDelegate.swift
//  SDKStarterSwift
//
//  Created by Muhammad Iqbal on 30/05/2016.
//  Copyright © 2016 Sentiance Corporation. All rights reserved.
//

import UIKit

let APPID = "YOUR_APP_ID"
let SECRET = "YOUR_APP_SECRET"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let sdk:SENTSDK = SENTSDK.sharedInstance() as! SENTSDK
        let config = SENTConfig.init(appId: APPID, secret: SECRET, launchOptions: launchOptions)

        sdk.initWith(config, success: {
            self.didAuthenticationSuccess()
            self.startSentianceSDK()
        }) { issue in
            print("SDK failed to init: \(issue)")
        }
        
        return true
    }

    func didAuthenticationSuccess() {
        let sdk: SENTSDK = SENTSDK.sharedInstance() as! SENTSDK

        print("==== Sentiance SDK started, version: \(sdk.getVersion())");
        print("==== Sentiance platform user id for this install: \(sdk.getUserId())");

        let notificationName = Notification.Name("SdkAuthenticationSuccess")
        NotificationCenter.default.post(name: notificationName, object: nil)
    }

    func startSentianceSDK() {
        let sdk: SENTSDK = SENTSDK.sharedInstance() as! SENTSDK
        sdk.start({ status in
            if let uStatus = status {
                if (uStatus.startStatus == .started) {
                    print("SDK started properly")
                } else if (uStatus.startStatus == .pending) {
                    print("Something prevented the SDK to start properly. Once fixed, the SDK will start automatically");
                } else {
                    print("SDK did not start");
                }

            }
        })
    }
    
    func stopSentianceSDK() {
        let sdk: SENTSDK = SENTSDK.sharedInstance() as! SENTSDK
        
        //To stop SDK
        sdk.stop()
        
        //You also can use postponed stop after X seconds
        //sdk.stop(after: 20)
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

