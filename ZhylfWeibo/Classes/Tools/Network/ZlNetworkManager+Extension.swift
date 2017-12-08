
//
//  ZlNetworkManager+Extension.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/17.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import Foundation
import HandyJSON

//封装新浪微博的请求
extension ZlNetworkManager {
    
    /// 加载微博数据字典数组
    ///
    ///   - since_id: 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    ///   - max_id:      若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    /// - Parameter completion: 完成回调  list: 微博字典数组 / 是否成功
    func statusList(since_id: Int64 = 0,max_id: Int64 = 0,completion: @escaping (_ list:[[String: AnyObject]], _ isSuccess: Bool)->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //swift 中 Int可以穿换成 AnyObject  但Int64不行
        let params = ["since_id": "\(since_id)",
                      "max_id": "\(max_id)"]
        
        
        tosenResquest(method: .GET, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            print(json as Any)
            //从 json 中 获取 statuses 字典数组
            //如果 as？ 失败 result = nil
            let result = json?["statuses"] as? [[String: AnyObject]]

            completion(result!, isSuccess)
            
        }
    }
    
    /// 返回微博的未读属性
    func unreadCount(completion:@escaping (_ count: Int)->()) {
        
        guard let uid = uid else {
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid": uid]
        
        tosenResquest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSucces) in
            let dict = json as? [String: AnyObject]
            let count = dict?["status"]
            
            completion(count as! Int )
        }
        
        
    }
    
}
