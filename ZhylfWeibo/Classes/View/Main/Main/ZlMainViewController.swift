//
//  ZlMainViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/2.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import SVProgressHUD

//主控制器
class ZlMainViewController: UITabBarController {
    
    //定时器
    private var timer: Timer?

    //MARK: - 私有控件
    // 中间按钮
    private lazy var composeButton:UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
//    lazy var composeButton:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: UserShouldLoginNotification), object: nil)

        // Do any additional setup after loading the view.
        setupChildController()
        setupComposeButton()
        setupTimer()
        //设置新特性试图
        setupNewFeatureViews()
        //测试未读数量
        //ZlNetworkManager.shared.unreadCount { (count) in
       //    print("有\(count)条未读消息")
        //}
        //设置代理
        delegate = self

        
    }
    
    deinit {
        //销毁时钟
        timer?.invalidate()
        
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - 监听方法
    
    @objc private func userLogin(n: Notification) {
        print("用户登录通知\(n)")
        var when = DispatchTime.now()
        //判断n.object 是否有值  如果有值提示用户重新登录
        if n.object != nil {
            //设置指示器渐变样式
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "用户登录已过期,请重新登录")
            when = DispatchTime.now() + 2
        }
        DispatchQueue.main.asyncAfter(deadline: when) {
            //展现登录控制器
            SVProgressHUD.setDefaultMaskType(.clear)
            let nav = UINavigationController(rootViewController: ZlOAuthViewController())
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    
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

// MARK: - 设置新特性试图
extension ZlMainViewController {
    /**
     *版本号的组成 主版本号 次级版本，修改版本号
     *主版本号：意味着打的修改 使用者需要做大的适应
     *次级版本：意味着小的修改  某些函数和方法或者参数有变动
     *修改版本号：框架/程序内部 bug的修改 不会对用户使用造成任何影响
     */
    private func setupNewFeatureViews () {
        //判断是否登录
        if !ZlNetworkManager.shared.userLogon {
            return
        }
        //1.检查是否为新版本
        
        //2.如果更新 显示新特性试图 否则显示欢迎
        let v = isNewVersion ? ZlNewFeatureView () : ZlWelcomeView.welcomeView()
        
        //3.显示试图
//        v.frame = view.bounds
        view.addSubview(v)
    }
    ///extension 中可以有计算行属性 不会占用存储空间
    private var isNewVersion: Bool {
        //1.取当前的版本号
//        print(Bundle.main.infoDictionary!)
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        print(currentVersion)
        //2.取之前的版本号（沙盒中存储的版本号）
        let path: String = ("version" as NSString).cz_appendDocumentDir()
        let sandboxVersion = (try? String(contentsOfFile: path)) ?? ""
        
        //3.将当前版本号保存在沙盒
       _ = try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        //4.返回两个版本是否一致
        
        return currentVersion != sandboxVersion 
    }
        
}

//MARK: - UITabBarControllerDelegate
extension ZlMainViewController: UITabBarControllerDelegate {
    /// 将要选择 tabBarItem
    ///
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: 目标控制器
    /// - Returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("将要切换到\(viewController)")
        
        //判断目标控制器是否是 UIViewController
        
        //1> 获取控制器在数组中的索引
        let idx = (childViewControllers as NSArray).index(of: viewController)
        //2> 获取当前索引 同时 idx 也是首页 重复点击首页按钮
        if selectedIndex == 0 && idx == selectedIndex {
            print("点击首页")
            //3> 将表格切换到最顶部
            //a) 获取到控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! ZlHomeViewController
            
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            //4>刷新数据 - 增加延迟  让表格滚动到顶部再刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                vc.loadData()
                //点击后将首页的badgeNumber 设置 nil
                self.tabBar.items?[0].badgeValue = nil
            })
        }
        
        
        return !viewController.isMember(of: UIViewController.self)
    }
}


//MARK: - 时钟相关方法
extension ZlMainViewController {
    
    private func setupTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 120000.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer (){
//        print(#function)
        if !ZlNetworkManager.shared.userLogon {
            return
        }
        ZlNetworkManager.shared.unreadCount { (count) in
            print("检测到\(count)条微博")
            //设置 首页 tabBatItem 的badgeNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            
            //设置app 的 badgeNumber 8.0 以后需要用户授权
            UIApplication.shared.applicationIconBadgeNumber = count
        }
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
    //将向内的宽度减
    let w = tabBar.bounds.width / count
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
        // 反序列化 throw 抛出异常
        // 方法一：推荐 try？ 如果解析成功 就有值  否则 为 nil
        // 方法一：强烈不推荐 try！ 如果解析成功 就有值  否则崩溃
        //  try catch 一旦不平衡 就会出现内存泄露
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







