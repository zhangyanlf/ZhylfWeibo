//
//  Bundle+Extension.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/9.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import Foundation

extension Bundle {
    
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}
