//
//  ZlNetworkManager+Extension.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/17.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import Foundation

//封装新浪微博的请求
extension ZlNetworkManager {
    
    /// 加载微博数据字典数组
    ///
    /// - Parameter completion: 完成回调  list: 微博字典数组 / 是否成功
    func statusList(completion: @escaping (_ list:[[String: AnyObject]], _ isSuccess: Bool)->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token":"2.009Tv21E6wpHnD83a4f871d1R_9fnB"]
        
        request(method: .GET, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            print(json as Any)
            //从 json 中 获取 statuses 字典数组
            //如果 as？ 失败 result = nil
            let result = json?["statuses"] as? [[String: AnyObject]]
            
            completion(result!, isSuccess)
            
        }
    }
}
