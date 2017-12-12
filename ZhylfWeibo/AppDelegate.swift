//
//  AppDelegate.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/1.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking
//find . -name "*.swift" | xargs wc -l
//查看代码行数

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        
        
        //10以前的取得用户的授权显示通知（上方的提示条/通知/badgeNumber）
        
        // Override point for customization after application launch.
        window = UIWindow()
        
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = ZlMainViewController()
        
        window?.makeKeyAndVisible()
        //从服务器加载应用程序信息
        loadAppInfo()
        //应用程序额外设置
        setupAdditions()
        return true
    }


}
//MARK: - 设置应用程序额外信息
extension AppDelegate {
    
    private func setupAdditions() {
        //1.设置SVProgressHUD 最小时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        //2.设置网络指示加载器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        //3.设置用户授权显示通知
        //10以上版本 的取得用户的授权显示通知
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.carPlay,.badge]) { (success, error) in
                print("授权\(success ? "成功":"失败")")
            }
        } else { //10以下
            let notifySettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
        }
    }
    
    
}

///MARK: - 从服务器加载应用程序信息
extension AppDelegate {
    private func loadAppInfo() {
        DispatchQueue.global().async {
            //1> url
            let url = Bundle.main.url(forResource: "zhangyanlf.json", withExtension: nil)
            
            //2> data
            let data = NSData(contentsOf: url!)
            
            //3> 写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("zhangyanlf.json")
            
            //保存草沙盒  程序下次启动使用
            data?.write(toFile: jsonPath, atomically: true)
            
            print("应用程序加载完毕\(jsonPath)")
        
        }
    }
    
}




