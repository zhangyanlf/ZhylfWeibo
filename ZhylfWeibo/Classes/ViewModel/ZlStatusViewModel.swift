//
//  ZlStatusViewModel.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/15.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import Foundation

/// 单条微博的试图模型
class ZlStatusViewModel {
    
    /// 微博模型
    var status: ZlStatus
    
    /// 构造函数
    ///
    /// - Parameter model: 微博模型
    /// - returns: 微博的试图模型
    init(model: ZlStatus) {
        self.status = model
    }
    
}
