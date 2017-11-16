//
//  ZlNetworkManager.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/16.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import AFNetworking

//网络管理工具
class ZlNetworkManager: AFHTTPSessionManager {

    ///静态区 / 常量 /闭包
    ///在第一次访问的时候  执行闭包 并且将接货保存在 shared
    static let shared = ZlNetworkManager()
}
