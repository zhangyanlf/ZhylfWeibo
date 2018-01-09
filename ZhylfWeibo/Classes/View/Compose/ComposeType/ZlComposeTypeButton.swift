//
//  ZlComposeTypeButton.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2018/1/2.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit
//UIControl 内置了touchUpInside 事件响应
class ZlComposeTypeButton: UIControl {
    /// 按钮图片
    @IBOutlet weak var composeButtonImageView: UIImageView!
    /// 按钮文字
    @IBOutlet weak var composeButtonLabel: UILabel!
    ///点击按钮要展现控制器的类名
    var clsName: String?
    
    
    /// 使用图像名称/标题创建按钮 按钮布局从XIB加载
    class func composeTypeButton(imageName: String, title: String) -> ZlComposeTypeButton {
        let nib = UINib(nibName: "ZlComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! ZlComposeTypeButton
        
        btn.composeButtonImageView.image = UIImage(named: imageName)
        btn.composeButtonLabel.text = title
        
        return btn
        
    }
}
