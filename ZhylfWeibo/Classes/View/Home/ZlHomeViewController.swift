//
//  ZlHomeViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/2.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
//定义全局常量  尽量使用 private 修饰，否则到处都能使用
private let cellId = "cellId"
class ZlHomeViewController: ZlBaseViewController {

    private lazy var statusList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    ///加载数据
    override func loadData() {
        
        for i in 0..<10 {
            //将数据插入到数组的顶部
            statusList.insert(i.description, at: 0)
        }
        
    }
    
    ///显示好友
    @objc private func showFrinds() {
        print(#function)
        let vc = ZlTestViewController()
//        vc.hidesBottomBarWhenPushed = true
        
        //push 的动作是 nav
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
//MARK: - 表格数据源方法
extension ZlHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        1.取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        //2.设置cell
        cell.textLabel?.text = statusList[indexPath.row]
        
        //3.返回cell
        return cell
    }
    
}



//MARK: - 设置界面
extension ZlHomeViewController {
    //重写父类的方法
    override func setupUI() {
        super.setupUI()
        
        //设置导航栏按钮
        //无法高亮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFrinds))
        
        
        //Swift 调用 OC 返回 instancetype 的方法 判断不出是否可选
//        let btn: UIButton = UIButton.cz_textButton("好友", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
//
//        btn.addTarget(self, action: #selector(showFrinds), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:btn)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 16, target: self, action: #selector(showFrinds))
        
        
        //注册原型cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
}

    
