//
//  ZlBaseViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/2.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlBaseViewController: UIViewController {

    /// 自定义导航
    lazy var navigationBar = ZLNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    ///自定义导航条目  - 设置导航栏内容，同意使用navItem
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }
    
    // 重写 title 的 didSet 
    override var title: String?{
        didSet {
            navItem.title = title
        }
    }
}

//MARK: - 设置界面
extension ZlBaseViewController {
   @objc public func setupUI() {
         view.backgroundColor = UIColor.cz_random()
    
        //添加导航条
        view.addSubview(navigationBar)
        //将item 这只给 bar
        navigationBar.items = [navItem]
    
        //设置navItem的渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
    
        //设置navigationBar 的字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
    }
}
