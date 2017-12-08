//
//  ZlOAuthViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/8.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
// 通过 webView 展示微博的授权页面
class ZlOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = webView
        view.backgroundColor = UIColor.white
        
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close), isBack: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - 监听方法
    @objc private func close (){
        dismiss(animated: true, completion: nil)
    }
}
