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
    }
    
    var description: String {
        return status.description
    }
    
}
