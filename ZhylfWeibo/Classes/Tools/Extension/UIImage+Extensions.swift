//
//  UIImage+Extensions.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/19.
//  Copyright © 2017年 zhangyanlf. All rights reserved.

import UIKit


extension UIImage{
    
    /// 创建图片，圆角
    ///
    /// - Parameters:
    ///   - size: 尺寸
    ///   - backColor: 背景色
    /// - Returns: 裁切后的图像
    func zl_avatarImage(size:CGSize?,backColor:UIColor = UIColor.white,lineColor:UIColor = UIColor.lightGray) -> UIImage? {
        var size = size
        if size == nil {
            size = self.size
        }
        let rect  = CGRect(origin: CGPoint(), size: size!)
        
        /*
         1>size
         2>不透明 (混合) png图片支持透明 jpg 图形不支持透明
         3>屏幕分辨率 如果不指定，默认使用1.0的分辨率（图片质量不好）
         指定0，会选择当前设备屏幕的分辨率
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        // 圆角
        // （0） 背景填充
        backColor.setFill()
        UIRectFill(rect)
        // （1） 原型路径
        let path = UIBezierPath(ovalIn: rect)
        // （2） 路径裁切
        path.addClip()
        // 2 绘图
        draw(in: rect)

        // 绘制内切原型
        let ovaPath = UIBezierPath(ovalIn: rect)
        
        lineColor.setStroke()
        
        ovaPath.lineWidth = 2
        
        ovaPath.stroke()
        
        // 3 取得新的图像
        let result = UIGraphicsGetImageFromCurrentImageContext()
        // 4 关闭上下文
        UIGraphicsEndImageContext()
        // 5 返回结果
        return result
        
    }
    
}
