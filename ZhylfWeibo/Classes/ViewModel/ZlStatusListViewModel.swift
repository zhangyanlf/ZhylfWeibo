//
//  ZlStatusListViewModel.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/17.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import Foundation
import HandyJSON
import SDWebImage
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
                self.cacheSingleImage(list: array, finished: completion)
                //4.完成回调  真正收数据的回调(完成单张缓存后回调)
//                completion(isSuccess, true)
            }
           
        }
        
    }
    
    
    /// 缓存本次下载数据中的单张图片
    ///
    /// - 应该缓存完单张图像  并且修改过配图的大小之后  再回调 才能保证表格等比例显示单张图片！
    ///
    /// - Parameter list: 单条微博的试图模型
    private func cacheSingleImage (list: [ZlStatusViewModel],finished: @escaping (_ isSuccess: Bool, _ hasMorePullUp: Bool)->()) {
        
        //调度组
        let group = DispatchGroup()
        
        
        /// 记录数据长度
        var length = 0
        
        
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
//            print("要缓存的 URL 图片是\(url)")
            
            //A> 入组
            group.enter()
            
            //3> 下载图像
            //1>downloadImage 是 SDWebImage 的核心方法
            //2>图片下载完成后 会自动保存在沙盒中 文件路径是 url 的 md5
            //3>如果沙盒中已经存在缓存的对象 后续使用 SD 通过 URL 加载图像 都会加载本地沙盒的图像
            //4>不会发起网络请求 同时 毁掉方法 同样会调用
            //5> 方法还是同样的方法 回调还是同样的回调  只不过内部不会再次发起网络请求
            //***** 注意：如果累计的缓存的图片累计较大  要找后台要接口 处理！
            SDWebImageDownloader.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _) in
                //将图片转换为二进制图片
                if let image = image,
                    let data = UIImagePNGRepresentation(image) {
                    //NSData 是 length 属性
                    length += data.count
                    
                    //图片缓存成功  更新配图试图大小
                    vm.updateSingleImageSize(image: image)
                }
                
                print("缓存的图像是\(String(describing: image))长度\(length)")
                
                //B> 出组 闭包的最后一句
                group.leave()
            })
        }
        
        //C> 监听调度组情况
        group.notify(queue: DispatchQueue.main) {
            print("图片缓存完成\(length/1024)K")
            
            //执行闭包回调
            finished(true, true)
        }
    }
}

