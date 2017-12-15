//
//  ZlWelcomeView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/13.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import SDWebImage
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
    //initcoder 只是刚刚从Xib的二进制文件将数据加载完成
    //还没有和代码建立关系 所以开发时 不能处理UI
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        print("nitcoder\(iconView)")
//    }
    
    override func awakeFromNib() {
        print("awakeFromNib\(iconView)")
        //1.url
        guard let urlString = ZlNetworkManager.shared.userAccount.avatar_large,
            let url = URL(string: urlString) else {
            return
        }
        //2. 设置头像
        iconView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "avatar_default_big"))
    
    }
    
    
    //试图添加到window上  表示试图已经显示
    override func didMoveToWindow() {
        super.didMoveToWindow()
        //试图是使用自动布局设置的 只是设置了约束
        //- 当试图被添加到窗口上 根据父试图的大小 计算约束值 更新控件位置
        //layoutIfNeeded 会直接按照当前的约束直接更新控件位置
        //执行之后 控件所在位置就是 XIB 中布局的位置
        self.layoutIfNeeded()
        
        bottomtConstraint.constant = bounds.size.width + 50
        
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
            UIView.animate(withDuration: 1.0, animations: {
                self.tipLabel.alpha = 1
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
    }
    
}
