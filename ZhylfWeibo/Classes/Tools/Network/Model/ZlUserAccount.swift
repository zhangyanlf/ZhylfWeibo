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
    var access_token: String?
    /// 用户uid
    var uid: String?
    
    /// 过期日期 单位秒
    ///开发者 5年
    ///使用者 3天
    var expires_in: TimeInterval = 0
    
    override var description: String {
        return yy_modelDescription()
    }
    
    
    

}
