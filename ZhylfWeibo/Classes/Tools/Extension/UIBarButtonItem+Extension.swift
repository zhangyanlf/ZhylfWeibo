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
    
    convenience init(title: String,fontSize:CGFloat = 16,target: AnyObject,action: Selector) {
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView:btn)
//        实例化UIBarButtonItem
        self.init(customView: btn)
    }
    
}
