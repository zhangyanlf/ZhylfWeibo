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

    //MARK: - 私有控件
    // 中间按钮
    private lazy var composeButton:UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
//    lazy var composeButton:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupChildController()
        setupComposeButton()
        
    }
    
    //MARK: - 监听方法
    /// 中间按钮
    //FIXME: 没有实现
    //private 保证方法私有 仅在当前对象被访问
    //@objc 允许这个函数 在 运行时 通过OC的消息机制被调用
   @objc private func composeButtonClick() {
        print("我是中间按钮")
    }
    
   

}

// extension 类似于 OC 中的 分类 在swift 中还可以用来切分代码块
//可以把相近的功能的函数 放在一个 extension 中
//便于代码维护
//注意：和OC 的分类方法一样 extension 中不能定义属性
//MARK: - 设置界面
extension ZlMainViewController {
   
   private func setupComposeButton() {
    
//    composeButton.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
//    composeButton.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
//    composeButton.sizeToFit()
    
        tabBar.addSubview(composeButton)
    
        //计算按钮的宽度
    let count = CGFloat(childViewControllers.count)
    //将向内的宽度减小 能够让按钮的宽度变大 盖住容错点 防止穿帮
    let w = tabBar.bounds.width / count - 1
//    CGRectInset 正数向内推进 负数 向外扩展
    composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
    
    //添加按钮方法
    composeButton.addTarget(self, action: #selector(composeButtonClick), for: .touchUpInside)
    
    
    }
    
    //设置所有子控制器
   private func setupChildController() {
        let array = [
            ["clsName": "ZlHomeViewController", "title": "首页", "imageName": "home"],
            ["clsName": "ZlMessageViewController", "title": "消息", "imageName": "message_center"],
            ["clsName": "UIViewViewController"],
            ["clsName": "ZlDescoverViewController", "title": "发现", "imageName": "discover"],
            ["clsName": "ZlProfileViewController", "title": "我", "imageName": "profile"],
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
        
        //3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //这只tabbar 标题字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .highlighted)

        //初始化导航控制器的时候 会调用push方法 将rootVC压栈
        let nav = ZlNavigationController(rootViewController: vc)
        
        return nav
        
        
       
    }
    
}







