//
//  ZlRefreshView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/27.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

/// 刷新试图 -- 负责刷新相关 UI 显示和动画
class ZlRefreshView: UIView {
    ///刷新状态
    var refreshState:ZlRefreshState = .Normal
    
    /// 提示图标
    @IBOutlet weak var pullRefreshImageView: UIImageView!
    
    /// 提示标签
    @IBOutlet weak var refreshLabel: UILabel!
    
    /// 指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    class func refreshView() -> ZlRefreshView {
        
        let nib = UINib(nibName: "ZlRefreshView", bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil)[0] as! ZlRefreshView
    }
    
}
