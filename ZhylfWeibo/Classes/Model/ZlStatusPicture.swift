//
//  ZlStatusPicture.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/19.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
///微博配图模型
class ZlStatusPicture: NSObject {

    /// 缩略图地址
    @objc var thumbnail_pic: NSString?
    
    override var description: String {
        return yy_modelDescription()
    }
    
}
