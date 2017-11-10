//
//  ZlTestViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/10.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlTestViewController: ZlBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置标题
        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
    }
    

    /// 监听方法
    @objc private func showNext() {
        let vc = ZlTestViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ZlTestViewController {
    //重写父类的方法
    override func setupUI() {
        
        super.setupUI()
        //设置右侧的控制器
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(showNext))
//        let btn: UIButton = UIButton.cz_textButton("下一个", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
//
//        btn.addTarget(self, action: #selector(showNext), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:btn)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
    }
}
