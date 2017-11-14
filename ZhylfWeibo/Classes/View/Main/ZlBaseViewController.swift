//
//  ZlBaseViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/2.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

//***OC 中不支持多继承 如何替代？ 使用协议替代
//class ZlBaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
// Swift中 可以利用 extension 可以把‘函数’按照功能分类管理 便于阅读和维护
//1. extension 中不能有属性
//2. extension 中不能重写父类方法 重写父类的方法 是子类的职责 扩展是对类的扩展

class ZlBaseViewController: UIViewController {
    /// 表格试图 - 如果用户没有登录 就不创建
    var tableView: UITableView?
    /// 刷新控件
    var refreshControl: UIRefreshControl?
    /// 上拉刷新标记
    var isPullup = false
    
    
    /// 自定义导航
    lazy var navigationBar = ZLNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    ///自定义导航条目  - 设置导航栏内容，同意使用navItem
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
       loadData()
    }
    
    // 重写 title 的 didSet 
    override var title: String?{
        didSet {
            navItem.title = title
        }
    }
    ///加载数据 - 具体的实现由子类负责
    @objc func loadData() {
        
    }
}

//MARK: - 设置界面
extension ZlBaseViewController {
   @objc public func setupUI() {
         view.backgroundColor = UIColor.cz_random()
        // 取消自动缩进 - 如果隐藏了导航栏  会缩进 20 个点
    if #available(iOS 11.0, *) {
        tableView?.contentInsetAdjustmentBehavior = .never
        
    } else {
        automaticallyAdjustsScrollViewInsets = false;
    };
        setupNavigationBar()
        setupTableView()
    }
    /// 设置表格试图
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        //设置数据源&代理 -> 目的： 子类直接实现数据源方法
        tableView?.delegate = self
        tableView?.dataSource = self
        
        //这是内容缩进
        //TODO:bottom 在iOS11 以下的兼容
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height - 20,
                                               left: 0,
                                               bottom: /*tabBarController?.tabBar.bounds.height ??*/ 0,
                                               right: 0)
        
        //设置刷新控件
        //1> 实例化控件
        refreshControl = UIRefreshControl()
        
        //2.添加到表格试图
        tableView?.addSubview(refreshControl!)
        
        //3> 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    ///设置导航栏
    func setupNavigationBar() {
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
//MARK: - UITableViewDataSource,UITableViewDelegate

extension ZlBaseViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    //基类只是准备方法  子类负责具体的实现
    //子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //只是保证没有语法错误
        return UITableViewCell()
    }
    ///在显示最后一行的时候做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //1.判断IndexPath是否为最后一行(indexPath.section(最大)的indexPath.row(最后一行))
        let row = indexPath.row
        //2>section
        let section = tableView.numberOfSections - 1
        //3> 行数
        let count = tableView.numberOfRows(inSection: section)
        
        /// 如果是最后 同时没有上拉刷新
        if row == (count - 1) && !isPullup {
            print("上拉刷新")
            isPullup = true
            
            //开始刷新
            loadData()
        }
        
        
    }
    
}
