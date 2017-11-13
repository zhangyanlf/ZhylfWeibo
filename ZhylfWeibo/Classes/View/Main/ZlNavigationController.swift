//
//  ZlNavigationController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/2.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏navigationBar
        navigationBar.isHidden = true
        
    }
    
    
    //重写 push 方法 所有的 push 动作 都会调用此方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        print(viewController)
        //如果不是栈低控制器才需要隐藏  跟控制器不需要隐藏
        if childViewControllers.count > 0 {
            //隐藏底部的Tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    

}
