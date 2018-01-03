//
//  ZlComposeTypeView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/29.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

/// 撰写微博类型试图
class ZlComposeTypeView: UIView {
    class func composeTypeView() ->ZlComposeTypeView {
        
        let nib = UINib(nibName: "ZlComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! ZlComposeTypeView
        
        return v
    }
    
    /// 显示当前试图
    func show() {
        //1> 将当前视图添加到 根试图控制器的 view
       guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        //2> 添加试图
        vc.view.addSubview(self)       
        
    }
    
   
    @IBAction func closeButton(_ sender: UIButton) {
        
        self.removeFromSuperview()
    }
    
}
