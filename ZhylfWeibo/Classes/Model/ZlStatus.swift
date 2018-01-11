//
//  ZlStatus.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/17.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import YYModel

/// 微博数据模型
class ZlStatus: NSObject {

    //int 类型在64位机器是 64位 在32位机器是 32位
    //如果不写 Int64 低版本都无法正常运行
   @objc var id: Int64 = 0
    //微博信息内容
   @objc var text: String?
    
    //创建时间
    @objc  var created_at:String?
    /// 微博来源
    @objc  var source: NSString? {
        didSet {
            source = "来自 " + ((source! as String).zl_href()?.text ?? "") as NSString
        }
    }
   
    /// 转发数
    @objc var reposts_count: Int64 = 0
    /// 评论数
    @objc var comments_count: Int64 = 0
    /// 表态数
    @objc var attitudes_count: Int64 = 0
    
    ///用户
    @objc var user: ZlUser?
    
    /// 被转发的原创
    @objc var retweeted_status: ZlStatus?
    
    /// 微博配置模型数组
    @objc  var pic_urls: [ZlStatusPicture]?
    
   
    
    
    
    //重写 description 计算行属性
    override var description: String {
        return yy_modelDescription()
       
    }
    
    ///类函数，告诉YY_Model 如果遇到数组类型的属性，数组中存放的对象是什么类
    ///运行时 YY_Model字典转模型，发现数组属性 尝试调用类方法modelContainerPropertyGenericClass，实例化数组中的对象
    ///NSArray中保存对象的类型是'id'类型 OC中的泛型是Swift退出后为了兼容添加的，在运行时的角度，并不知道数组中存放的什么类型的对象
    @objc class func modelContainerPropertyGenericClass() -> [String:AnyClass] {
        return ["pic_urls":ZlStatusPicture.self]
    }
    
    
}
