//
//  ZlHomeViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/2.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlHomeViewController: ZlBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //显示好友
    @objc private func showFrinds() {
        print(#function)
        let vc = ZlTestViewController()
//        vc.hidesBottomBarWhenPushed = true
        
        //push 的动作是 nav
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ZlHomeViewController {
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 16, target: self, action: #selector(showFrinds))
        
    }
    
}

    
