//
//  ZlHomeViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/2.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import Alamofire
//定义全局常量  尽量使用 private 修饰，否则到处都能使用
///原创微博可重用cellId
private let originalCellId = "originalCellId"
/// 转发微博可重用CellId
private let retweetedCellId = "retweetedCellId"
class ZlHomeViewController: ZlBaseViewController {
    //列表试图模型
    private lazy var listViewModel = ZlStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    ///加载数据
    override func loadData() {
        //print("准备刷新，最后一条\(String(describing: self.listViewModel.statusList.last?.text))")
        refreshControl?.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.listViewModel.loadStatus(pullup: self.isPullup) { (isSucess,shouldRefresh) in
                print("加载表格结束")
                
                //结束刷新
                self.refreshControl?.endRefreshing()
                //恢复上拉刷新标记
                self.isPullup = false
                //刷新表格
                if shouldRefresh {
                    self.tableView?.reloadData()
                }
            }
        
           
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
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //0 取出试图模型 根据试图模型判断可重用 Cell
        let viewModel = listViewModel.statusList[indexPath.row]
        let cellId = (viewModel.status.retweeted_status != nil) ? retweetedCellId : originalCellId
//        1.取cell - 本身会调用代理方法（若果有）
        //如果没有  找到Cell 按照自动布局的规则 从上向下计算 找到向下的约束 从而计算高度
        //FIXME: 修改ID
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ZlStatusCell
        
        //2.设置cell
        cell.viewModel = viewModel
        
        //3.返回cell
        return cell
    }
    
    // 父类必须实现代理方法  子类才能够重写 Swift3.0 如此 2.0 不需要
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //1.根据indexPath 获取试图模型
        let vm = listViewModel.statusList[indexPath.row]
        
        //2. 返回计算好的行高
         print(vm.rowHeight)
        return vm.rowHeight
       
        
    }
    
}



//MARK: - 设置界面
extension ZlHomeViewController {
    //重写父类的方法
    override func setupTableView() {
        super.setupTableView()
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
        //tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView?.register(UINib(nibName: "ZlStatusNormalCell", bundle: nil), forCellReuseIdentifier: originalCellId)
        tableView?.register(UINib(nibName: "ZlStatusRetwitterCell", bundle: nil), forCellReuseIdentifier: retweetedCellId)
        
        //设置行高
        //缓存行高之后 去掉自动设置行高
        //tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        //取消分割线
        tableView?.separatorStyle = .none
        
        setupNavtitle()
    }
    
    /// 设置导航栏标题
    private func setupNavtitle() {
        
        let titleName = ZlNetworkManager.shared.userAccount.screen_name
        print(ZlNetworkManager.shared.userAccount)
        let button = ZlTitleButton(title: titleName)
       
        button.sizeToFit()
        navItem.titleView = button
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
    }
    
    @objc func clickTitleButton(btn: UIButton) {
        
        //设置选中状态
        btn.isSelected = !btn.isSelected
        print("点击后\(btn.frame)")
    }
    
    
}

    
