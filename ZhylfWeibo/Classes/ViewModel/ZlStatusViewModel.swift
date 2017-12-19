//
//  ZlStatusViewModel.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/15.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import Foundation

/// 单条微博的试图模型
/**
 如果没有任何父类  如果希望在开发时调试 书出台需要输出信息 需要
 1.遵守 CustomStringConvertible
 2.实现 description 计算性属性
 
 关于表格的性能优化
 - 尽量少计算， 所有需要的素材提前计算好
 - 控件不要设置圆角半径  图片渲染的属性都要注意
 - 不要动态创建组件  所有需要的控件 都要提前创建好 在现实的时候 根据数据显示/隐藏
 - cell中控件的数量越少越好
 - 要测量 不要猜测
 */
class ZlStatusViewModel: CustomStringConvertible {
    
    /// 微博模型
    var status: ZlStatus
    
   /// vip图标
    /// 会员等级数 0-6
    var vipmberIcon: UIImage?
    
    /// 认证图标
    /// 认证类型 -1：没有认证 0：认证 2，3，5企业用户 220：达人
    var memberIcon: UIImage?
    
    /// 转发文字 有的话显示数字 没有的话显示转发
    var retweetStr: String?
    
    /// 评论数
    @objc var commentsStr: String?
    /// 表态数
    @objc var attitudesStr: String?
    
    /// 配图试图大小
    var pictureViewSize = CGSize()
    
    
    
    /// 构造函数
    ///
    /// - Parameter model: 微博模型
    /// - returns: 微博的试图模型
    init(model: ZlStatus) {
        self.status = model
        
        //common_icon_membership_level1
        //会员等级数 0-6
         if (model.user?.mbrank) ?? 0 > 0 && ((model.user?.mbrank)) ?? 0 < 7{
            let inageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            vipmberIcon = UIImage(named: inageName)
         } else {
            let inageName = "common_icon_membership_expired"
            vipmberIcon = UIImage(named: inageName)
           
        }
        ///认证图标
        switch model.user?.verified_type ?? -1 {
        case 0:
            memberIcon = UIImage(named: "avatar_vip")
        case 2,3,5:
            memberIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            memberIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
        ///设置底部计数字符串
        //测试计算大于10000
        //model.comments_count = Int64(Int(arc4random_uniform(100000)))
        retweetStr = countString(count: Int(model.reposts_count), defaultStr: "转发")
        commentsStr = countString(count: Int(model.comments_count), defaultStr: "评论")
        attitudesStr = countString(count: Int(model.attitudes_count), defaultStr: "赞")
        
        ///计算配图大小
        pictureViewSize = calaPictureViewSize(count: (status.pic_urls?.count)!)
    }
    
    var description: String {
        return status.description
    }
    
    /// 计算指定数量的图片对应的配图试图的大小
    ///
    /// - Parameter count: 配图数量
    /// - Returns: 配图试图的大小
    private func calaPictureViewSize(count: Int?) -> CGSize {
        //计算配图试图的宽度
        
        return CGSize(width: 100, height: 300)
    }
    
    /// 给定一个数字，返回对于的描述结果
    ///
    /// - Parameters:
    ///   - count: 数字
    ///   - defaultStr: 默认文字
    /// - Returns: 返回的描述结果
    /**
     count == 0 显示默认标题
     count > 10000 显示x.xx万
     count < 10000 显示原数字
     */
    private func countString (count: Int, defaultStr: String) -> String {
        if count == 0 {
            return defaultStr
        }
        if count < 10000 {
            return count.description
        }
        
        return String(format: "%.02f 万", Double(count) / 10000)
    }
    
    
    
}
