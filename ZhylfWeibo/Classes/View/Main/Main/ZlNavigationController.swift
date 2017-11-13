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
    //viewController 是被 push 的控制器  设置他的左侧按钮为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        print(viewController)
        //如果不是栈低控制器才需要隐藏  跟控制器不需要隐藏
        if childViewControllers.count > 0 {
            //隐藏底部的Tabbar
            viewController.hidesBottomBarWhenPushed = true

            //判断控制器的类型
            if let vc = viewController as? ZlBaseViewController {
            
            //取出自定义的navItem
                var title = "返回"
            //判断控制器的级数
                if childViewControllers.count == 1 {
                    //title等于首页的标题
                    title = childViewControllers.first?.title ?? "返回"
                }
            
            //自定义的 navItem 设置这左侧的作为返回按钮
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent),isBack: true)
              }
        }
        super.pushViewController(viewController, animated: true)
    }
    
    ///pop 返回到上一级控制器
    @objc private func popToParent() {
        popViewController(animated: true)
    }

}
