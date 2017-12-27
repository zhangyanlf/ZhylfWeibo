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
    /**
     系统中封装的动画旋转
     - 默认顺时针旋转
     - 就近原则
     - 要想实现同方向旋转  需要调整 一个非常小的数
     */
    var refreshState:ZlRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                //恢复状态
                pullRefreshImageView.isHidden = false
                indicator.stopAnimating()
                
                refreshLabel.text = "继续使劲拉..."
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.pullRefreshImageView.transform = CGAffineTransform.identity
                })
            case .Pulling:
                refreshLabel.text = "放手刷新..."
                UIView.animate(withDuration: 0.25, animations: {
                    self.pullRefreshImageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI - 0.001))
                })
                
            case .WillRefresh:
                refreshLabel.text = "正在刷新中..."
                
                //隐藏提示图标
                pullRefreshImageView.isHidden = true
                //显示菊花
                indicator.startAnimating()
            }
        }
    }
    
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
