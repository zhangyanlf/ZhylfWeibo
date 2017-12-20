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
    /// 微博试图模型数组的懒加载
    lazy var statusList = [ZlStatusViewModel]()
    
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
        let since_id = pullup ? 0 : (statusList.first?.status.id ?? 0)
        
        //max_id  上拉刷新 取出数组中最后一项
        let max_id = !pullup ? 0 : (self.statusList.last?.status.id ?? 0)
        
        ZlNetworkManager.shared.statusList(since_id: since_id,max_id: max_id) { (list, isSuccess) in

            //0.网络请求是否成功
            if !isSuccess {
                //直接回调返回
                completion(false, false)
                return
            }
            
            //1.字典转模型
            var array = [ZlStatusViewModel]()
            //2.遍历服务器返回的字典类型 字典转模型
            for dict in list {
               // print(dict["pic_urls"])
                //a)创建微博类型 - 如果创建模型失败 继续后续的遍历
                guard  let model = ZlStatus.yy_model(with: dict) else {
                    continue
                }
               
                //b)将model添加到数组
                array.append(ZlStatusViewModel(model: model))
                
            }
            
            print("刷新到\(array.count)条数据 \(array)")
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
                self.cacheSingleImage(list: array)
                //4.完成回调  真正收数据的回调
                completion(isSuccess, true)
            }
           
        }
        
    }
    
    
    /// 缓存本次下载数据中的单张图片
    ///
    /// - Parameter list: 单条微博的试图模型
    private func cacheSingleImage (list: [ZlStatusViewModel]) {
        //遍历数组  查找数据有单张图片的进行缓存
        for vm in list {
            //1>判断图片数量
            if vm.pic_Urls?.count != 1 {
                continue
            }
            //2> 代码执行至此有且只有一张图片 获取 图像模型
            guard let pic = vm.pic_Urls![0].thumbnail_pic,
                let url = URL(string: pic as String) else {
                    continue
            }
            print("要缓存的 URL 图片是\(url)")
        }
    }
}

