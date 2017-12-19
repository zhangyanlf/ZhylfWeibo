//
//  ZlStatus.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/17.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import YYModel

class ZlStatus: NSObject {

    //int 类型在64位机器是 64位 在32位机器是 32位
    //如果不写 Int64 低版本都无法正常运行
   @objc var id: Int64 = 0
    //微博信息内容
   @objc var text: String?
    
    /// 转发数
    @objc var reposts_count: Int64 = 0
    /// 评论数
    @objc var comments_count: Int64 = 0
    /// 表态数
    @objc var attitudes_count: Int64 = 0
    
    ///用户
   @objc var user :ZlUser?
    
    
    //重写 description 计算行属性
    override var description: String {
        return yy_modelDescription()
    }

    
    
}
