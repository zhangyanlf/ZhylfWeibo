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
        //测试方向旋转
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.cz_random()
        let nav = UINavigationController(rootViewController: vc)
    
        present(nav, animated: true, completion: nil)
    }
    
    
    
    /**
     portrait: 竖屏  肖像
     landscape: 横屏 风景画
     
     - 使用代码控制设备的方向，好处  可以在需要的横屏的时候 单独处理
     - 设置支持的方向之后  当前的控制器及子控制器 都会遵守这个方向
     - 如果播放视频  通常是通过 modal 展现
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
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
    
        //从 bundle 加载配置的 Json
        //获取沙盒的文件路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("zhangyanlf.json")
        //加载data
    var data = NSData(contentsOfFile: jsonPath)
    
        //判断data 是否有内容 如果没有 说明本地沙盒没有文件
    if data == nil {
        //从Bundle 加载 data
       let path = Bundle.main.path(forResource: "zhangyanlf", ofType: "json")
       data = NSData(contentsOfFile: path!)
    }
    
        //1. 路径  2.记载NSData 3.反序列化转出数组
    guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: AnyObject]]
            else {
            return
        }
    
    
    
//        let array = [
//            ["clsName": "ZlHomeViewController", "title": "首页", "imageName": "home","visitorInfo": ["imageName":"","message":"关注一些人,回这里看看有什么惊喜"]],
//            ["clsName": "ZlMessageViewController", "title": "消息", "imageName": "message_center","visitorInfo": ["imageName":"visitordiscover_image_message","message":"登录后,别人发给你的微博,发给你的消息,都会在这里收到通知"]],
//            ["clsName": "UIViewViewController"],
//            ["clsName": "ZlDescoverViewController", "title": "发现", "imageName": "discover","visitorInfo": ["imageName":"visitordiscover_image_message","message":"登录后,最新、最热微博尽在掌握,不会与实时潮流擦肩而过"]],
//            ["clsName": "ZlProfileViewController", "title": "我", "imageName": "profile","visitorInfo": ["imageName":"visitordiscover_image_profile","message":"登录后,你的微博、相册、个人资料会显示在这里展示给别人"]],
//            ]
//        //测试JSON格式  转换成Plist
////        (array as NSArray).write(toFile: "/Users/zhaofei/Desktop/demo.plist", atomically: true)
//        //数组 -> JSON
//       let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
////       let fileURL = NSURL.fileURL(withPath: "/Users/zhaofei/Desktop/demo.plist")
//
//       (data as NSData).write(toFile: "/Users/zhaofei/Desktop/zhangyanlf.json", atomically: true)
    
    
    
        var arrayM = [UIViewController]()
    
        for dict in array! {
            arrayM.append(controller(dict: dict as [String : AnyObject]))
        }
        viewControllers = arrayM
    }
    
    private func controller(dict: [String: AnyObject]) -> UIViewController {
        //1.取得字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? ZlBaseViewController.Type,
        let visitorDict = dict["visitorInfo"] as? [String: String]   else {
            return UIViewController()
        }
        
        //2.创建试图控制器
//        1>将 clsName 转换成cls
        let vc = cls.init()
        vc.title = title
        
        //设置访客信息字典
        vc.visitorInfoDictionary = visitorDict
        
        //3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + (imageName as! String))
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + (imageName as! String) + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //这只tabbar 标题字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .highlighted)

        //初始化导航控制器的时候 会调用push方法 将rootVC压栈
        let nav = ZlNavigationController(rootViewController: vc)
        
        return nav
        
        
       
    }
    
}







