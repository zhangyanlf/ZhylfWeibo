//
//  UINavigationBar+Extension.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/10.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLNavigationBar: UINavigationBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in self.subviews {
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            print("--------- \(stringFromClass)")
            if stringFromClass.contains("BarBackground") {
                subview.frame = self.bounds
            } else if stringFromClass.contains("UINavigationBarContentView") {
                subview.frame = CGRect(x: 0.0, y: 20.0, width: subview.frame.size.width, height: 44.0)
            }
        }

    }
}


//extension UINavigationBar {
//    override open func layoutSubviews() {
//                super.layoutSubviews()
//                for subview in self.subviews {
//                    let stringFromClass = NSStringFromClass(subview.classForCoder)
////                    print("--------- \(stringFromClass)")
//                    if stringFromClass.contains("BarBackground") {
//                        subview.frame = self.bounds
//                    } else if stringFromClass.contains("UINavigationBarContentView") {
//                        subview.frame = CGRect(x: 0.0, y: 20.0, width: subview.frame.size.width, height: 44.0)
//                    }
//                }
//
//            }
//}




