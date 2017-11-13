//
//  UIBarButtonItem+Extension.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/10.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建UIBarButtonItem(zhangyanlf)
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize 默认16
    ///   - tatget: tatget
    ///   - action: action
    ///   -isBack: 判断是否为返回按钮，添加返回图片
    convenience init(title: String,fontSize:CGFloat = 16,target: AnyObject,action: Selector, isBack: Bool = false) {
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            btn.setImage(UIImage(named: imageName), for: .normal)
             btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView:btn)
//        实例化UIBarButtonItem
        self.init(customView: btn)
    }
    
}
