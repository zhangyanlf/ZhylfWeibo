//
//  NSString+Extension.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2018/1/11.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import Foundation

extension String {
    
    /// 从当前字符串中 查找链接和文本
    /// Swift中 提供了元组 可以同时返回多个值
    func zl_href() -> (link: String, text: String)? {
        
        //0.匹配方案
        let pattern = "<a href=\"(.*?)\" .*?>(.*?)</a>"
        //1.创建正则表达式
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []),
            let result =  regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length:characters.count)) else {
                return nil
        }
        //2.获取结果
        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
        
        return (link,text)
    }
}

