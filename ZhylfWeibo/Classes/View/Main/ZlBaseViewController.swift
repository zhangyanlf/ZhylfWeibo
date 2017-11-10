//
//  ZlBaseViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/2.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }

}

//MARK: - 设置界面
extension ZlBaseViewController {
   @objc public func setupUI() {
         view.backgroundColor = UIColor.cz_random()
    }
}
