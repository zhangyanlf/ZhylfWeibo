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
        
        //这只导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFrinds))
    }
    
}

    
