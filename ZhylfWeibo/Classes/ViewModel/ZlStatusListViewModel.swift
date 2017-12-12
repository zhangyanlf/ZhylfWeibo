//
//  ZlStatusListViewModel.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/17.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import Foundation
import HandyJSON
//数据列表试图模型
/*
 父类的选择
 
 - 如果类需要使用 KVC 或者 字典转模型设置对象值，类就需要继承与NSObject
 - 如果只是包装了一些代码逻辑(写了一些函数)，可以不需要任何父类   好处：更加轻量级
 - 提示：如果用OC写，一律都继承于NSObject
 
 作用： 数据处理
 */

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 3
class ZlStatusListViewModel {
    lazy var statusList = [ZlStatus]()
    
    /// 上拉刷新错误次数
    private var pullupErrorTimes = 0
    
    
    /// 加载列表
    ///
    /// - Parameter completion: 完成回调 (网络请求是否成功)
    ///   - pullup:上拉刷新标记 hasMorePullUp 是否有更多上拉刷新
    func loadStatus(pullup: Bool,completion: @escaping (_ isSuccess: Bool, _ hasMorePullUp: Bool)->())  {
        
        //判断是否是上拉刷新 同时检查刷新错误
        if pullup && self.pullupErrorTimes > maxPullupTryTimes {
            
            completion(true, false)
            
            return
        }
        
        //           since_id 取出数组中第一天微博的 id
        let since_id = pullup ? 0 : self.statusList.first?.id ?? 0
        
        //max_id  上拉刷新 取出数组中最后一项
        let max_id = !pullup ? 0 : (self.statusList.last?.id ?? 0)
        
        ZlNetworkManager.shared.statusList(since_id: since_id,max_id: max_id) { (list, isSuccess) in

            
            
            //1.字典转模型
            // var array = [ZlStatus]()
            // for dict in list {
            //      guard let model = ZlStatus.yy_model(with: dict) else{
            //          continue
            //      }
            //  model 添加数组
            //      array.append(model)
            //
            //   }
            guard let array = NSArray.yy_modelArray(with: ZlStatus.self, json: list) as? [ZlStatus] else{
                //字典转模型失败
                completion(isSuccess, false)
                return
            }
        
            
            print("array\(array)")
            //2.FIXME:拼接数据
            if pullup {
                //上拉刷新 应该将结果拼接在数组末尾
                self.statusList += array
            } else {
                //下拉刷新 ,应该将结果拼接在数组前面
                self.statusList += array + self.statusList
            }
           //3.判断上拉刷新的数据量
            if pullup && array.count == 0 {
                self.pullupErrorTimes += 1
                completion(isSuccess, false)
            } else {
                //4.完成回调
                completion(isSuccess, true)
            }
            
           
        }
        
    }
}
