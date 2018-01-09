//
//  ZlComposeViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2018/1/9.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

/// 撰写微博控制器
class ZlComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cz_random()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(clickBack))
    }
    
    @objc func clickBack() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
