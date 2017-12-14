//
//  ZlWelcomeView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/13.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
//欢迎界面
class ZlWelcomeView: UIView {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var bottomtConstraint: NSLayoutConstraint!
    class func welcomeView() -> ZlWelcomeView {
        
        let nib = UINib(nibName: "ZlWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! ZlWelcomeView
        // 从XIB 加载的试图 默认是 600 * 600
        v.frame = UIScreen.main.bounds
        
        return v
        
    }
    //试图添加到window上  表示试图已经显示
    override func didMoveToWindow() {
        super.didMoveToWindow()
        //试图是使用自动布局设置的 只是设置了约束
        //- 当试图被添加到窗口上 根据父试图的大小 计算约束值 更新控件位置
        //layoutIfNeeded 会直接按照当前的约束直接更新控件位置
        //执行之后 控件所在位置就是 XIB 中布局的位置
        self.layoutIfNeeded()
        
        bottomtConstraint.constant = bounds.size.width - 200
        
        //如果控件的 frame 还没有计算好 所有的约束都会一起动画
        UIView.animate(withDuration:3.0,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        //更新约束
                        self.layoutIfNeeded()
        }) { (_) in
            
        }
    }
    
}
