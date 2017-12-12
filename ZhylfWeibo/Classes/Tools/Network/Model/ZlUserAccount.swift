//
//  ZlUserAccount.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/11.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
private let accountFile: NSString = "userAccount.json"
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
    override init() {
        super.init()
        
        //1从磁盘加载保存的文件 -> 字典
       guard let path = accountFile.cz_appendDocumentDir(),
            let data = NSData(contentsOfFile: path),
        let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject] else {
            
                return
        }
        //2使用字典设置属性值
        //yy_modelSet(with: dict ?? [:])
        
        print("从沙盒加载用户信息\(self)")
        //判断token是否过期
        if expiresDate?.compare(Date()) != .orderedDescending {
            //print("账户过期")
            //清空用户信息
            access_token = nil
            uid = nil
            
            //长处用户文件
           _ = try? FileManager.default.removeItem(atPath: path)
            
        }
        print("账户正常")
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
            let fileName = accountFile.cz_appendDocumentDir() else {
            
                return
        }
        
        //3.写入磁盘
        (data as NSData).write(toFile: fileName, atomically: true)
        
        print("保存用户成功\(fileName)")
        
        
    }
    

}
