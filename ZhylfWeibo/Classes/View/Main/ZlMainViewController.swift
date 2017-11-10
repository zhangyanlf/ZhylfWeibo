//
//  ZlMainViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/2.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

//主控制器
class ZlMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupChildController()
        
    }

}

// extension 类似于 OC 中的 分类 在swift 中还可以用来切分代码块
//可以把相近的功能的函数 放在一个 extension 中
//便于代码维护
//注意：和OC 的分类方法一样 extension 中不能定义属性
//MARK: - 设置界面
extension ZlMainViewController {
   

    
    //设置所有子控制器
   private func setupChildController() {
        let array = [
            ["clsName": "ZlHomeViewController", "title": "首页", "imageName": ""],
            ]
        var arrayM = [UIViewController]()
    
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    
    private func controller(dict: [String: String]) -> UIViewController {
        //1.取得字典内容
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type else {
            return UIViewController()
        }
        
        //2.创建试图控制器
//        1>将 clsName 转换成cls
        let vc = cls.init()
        vc.title = title
        
        let nav = ZlNavigationController(rootViewController: vc)
        
        return nav
        
        
       
    }
    
}







