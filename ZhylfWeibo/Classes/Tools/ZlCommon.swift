//
//  ZlCommon.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/8.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import Foundation

//应用程序信息
/// 程序AppId
let ZlAppKey = "3474306921"
/// 用于程序加密信息
let ZlAppSecret = "0e9afa05ea3a56ace3085495e6480018"
/// 回调地址
let ZlRedirectURI = "http://zhangyanlf.cn"

//MARK: - 全局通知定义

/// 用户需要登录通知
let UserShouldLoginNotification = "UserShouldLoginNotification"
let UserLogoinSuccessedNotification = "UserLogoinSuccessedNotification"

///MARK: - 试图配图常量
//常数准备
///配图试图外侧的间距
let ZlStatusPictureViewOutterMargin = CGFloat(12)
///配图试图内部图像的间距
let ZlStatusPictureViewInnerMargin = CGFloat(3)

///试图的宽度
let ZlStatusPictureViewWidth = UIScreen.cz_screenWidth() - 2 * ZlStatusPictureViewOutterMargin
///每个item默认的高度
let ZlStatusPictureItemWidth = (ZlStatusPictureViewWidth - 2 * ZlStatusPictureViewInnerMargin) / 3

///适配NavBar 高度
let SafeAreaTopHeight = (UIScreen.cz_screenHeight() == 812.0 ? 88 : 64)
let NavBarTopHeight = (UIScreen.cz_screenHeight() == 812.0 ? 40.0 : 20.0)

/// 刷新状态切换的临界点
let ZlRefreshOffset: CGFloat = (UIScreen.cz_screenHeight() == 812.0 ? 150.0 : 126.0)


