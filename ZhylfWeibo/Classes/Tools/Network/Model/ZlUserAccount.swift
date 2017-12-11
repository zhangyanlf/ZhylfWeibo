//
//  ZlUserAccount.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/11.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlUserAccount: NSObject {
    ///访问令牌
    @objc var access_token: String?
    /// 用户uid
    @objc var uid: String?
    
    /// 过期日期 单位秒
    ///开发者 5年
    ///使用者 3天
   @objc var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    ///过期日期
   @objc var expiresDate: Date?
    
    
    override var description: String {
        return yy_modelDescription()
    }
    /**
     1.偏好设置
     2.沙盒 - 归档/plist/json
     3.数据库(FMDB/CoreData)
     4.钥匙串访问(小/自动加密   需要使用框架)
     **/
    func saveAccount()  {
        //1.模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String: AnyObject]) ?? [:]
        
        print("dict------\(String(describing: dict))")
        
        //需要删除 expires_in 值
        dict.removeValue(forKey: "expires_in")
        
        
        //2.字典序列化 data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
            let fileName = ("userAccount.json" as NSString).cz_appendDocumentDir() else {
            
                return
        }
        
        //3.写入磁盘
        (data as NSData).write(toFile: fileName, atomically: true)
        
        print("保存用户成功\(fileName)")
        
        
    }
    

}
