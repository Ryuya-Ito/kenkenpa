
//
//  AppDelegate.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2015/10/18.
//  Copyright (c) 2015年 Ryu. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var window : UIWindow?
        
        if ADFmyMovieReward.isSupportedOSVersion(){
            //rootViewcontrollerが取得出来たら、初期化を開始
            if let vc = self.window?.rootViewController{
                ADFmyMovieReward.initWithAppID("56d405592d34956f65000012", viewController: vc)
                
        NADInterstitial.sharedInstance().loadAdWithApiKey("3d3a8e656db3a06f31eeb8b96b80f5b44dea48f1",spotId:"550701")
                
            }
            
        }
        
        
        // ViewControllerを生成する.
        let myFirstViewController: FirstViewController = FirstViewController()
        
        // UIWindowを生成する.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // rootViewControllerにNatigationControllerを設定する.
        self.window?.rootViewController = myFirstViewController
        
        self.window?.makeKeyAndVisible()

        return true
        
    }
    
    /*func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }*/
    
    
}
