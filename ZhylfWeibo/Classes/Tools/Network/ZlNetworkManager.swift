//
//  ZlNetworkManager.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/16.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire

//swift 的枚举支持任意的数据类型
// switch / enum 在 OC 中只支持整数类型
enum ZlHTTPMethod {
    case GET
    case POST
}
//AFNetworking 封装
//网络管理工具
class ZlNetworkManager: AFHTTPSessionManager {

    ///静态区 / 常量 /闭包
    ///在第一次访问的时候  执行闭包 并且将接货保存在 shared
    static let shared = ZlNetworkManager()
    
    //访问令牌 所有网络请求 都基于令牌(登录除外)
    var accessToken: String? = "2.009Tv21E6wpHnD83a4f871d1R_9fnB"
    
    //专门负责拼接 token 的网络请求
    func tosenResquest(method: ZlHTTPMethod = .GET, URLString: String,parameters:[String:AnyObject]?,completion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()) {
        //处理 token 字典
        guard let token = accessToken else {
            completion(nil, false)
            return
        }
        //1>判断参数字典是否存在
        var parameters = parameters
        
        if parameters == nil {
            //实例化字典
            parameters = [String: AnyObject]()
        }
        //2> 设置参数字典
        parameters!["access_token"] = token as AnyObject
        //调用 request 发起真正的网络请求方法
        request(URLString: URLString, parameters: parameters, completion: completion)
        
        
        
    }

    ///封装AF 的 Get /Post
    ///
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调 json(字典/数组，是否成功)
    func request(method: ZlHTTPMethod = .GET, URLString: String,parameters:[String:AnyObject]?,completion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()) {


        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: { (task, json) in
                completion(json as AnyObject, true)
            }, failure: { (task, error) in

                print("网络请求错误\(error)")
                completion(nil, false)
            })
        }else{
            post(URLString, parameters: parameters, progress: nil, success: { (_, json) in
                completion(json as AnyObject, true)
            }, failure: { (task, error) in
                print("网络请求错误\(error)")
                completion(nil, false)
            })
        }
    }

}


/*
//MARK: - Alamofire 封装
private let NetworkRequestShareInstance = ZlNetworkManager()

class ZlNetworkManager {
    class var sharedInstance : ZlNetworkManager {
        return NetworkRequestShareInstance
    }
}

extension ZlNetworkManager {
    
    //MARK: - GET 请求
    
    func getRequest(urlString: String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        //使用Alamofire进行网络请求时，调用该方法的参数都是通过getRequest(urlString， params, success :, failture :）传入的，而success传入的其实是一个接受           [String : AnyObject]类型 返回void类型的函数
        
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { (response) in/*这里使用了闭包*/
                //当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
                //使用switch判断请求是否成功，也就是response的result
                switch response.result {
                case .success(let value):
                    //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                    //                    if let value = response.result.value as? [String: AnyObject] {
                    success(value as! [String : AnyObject])
                    //                    }
                   print(value)
                    
                case .failure(let error):
                    failture(error)
                    print("error:\(error)")
                }
        }
        
    }
    //MARK: - POST 请求
    func postRequest(urlString : String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    success(value)
                    print(value)
                }
            case .failure(let error):
                failture(error)
                print(error)
            }
            
        }
    }

}

 */


