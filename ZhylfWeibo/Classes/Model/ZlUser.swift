//
//  ZlUser.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/15.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

/// 微博用户模型
class ZlUser: NSObject {
    //进本数据类型 & private 不能使用 KVC 设置
    var id: Int64 = 0
    /// 用户昵称
    var screen_name: NSString?
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: NSString?
    /// 认证类型 -1：没有认证 0：认证 2，3，5企业用户 220：达人
    var verified_type: Int = 0
    /// 会员等级数 0-6
    var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
    
}
