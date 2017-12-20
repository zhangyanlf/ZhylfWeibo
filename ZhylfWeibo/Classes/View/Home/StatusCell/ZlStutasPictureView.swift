//
//  ZlStutasPictureView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/19.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlStutasPictureView: UIView {
    /// 配图试图的数组
    var urls: [ZlStatusPicture]? {
        didSet {
           //1.隐藏所有的imageView
            for v in subviews {
                v.isHidden = true
            }
            
            //设置图像   遍历urls数组 顺序设置图像
            var index = 0
            
            for url in urls ?? []{
                //获得索引的imageView
                let iv = subviews[index] as! UIImageView
                //FIXME: 4张图片处理
                if index == 1 && urls?.count == 4 {
                    index += 1
                }

                //设置头像
                iv.zl_setupImage(urlString: url.thumbnail_pic! as String, placeholderImage: nil)
                //显示图像
                iv.isHidden = false
                index += 1
            }
        }
    }
    
    /// 照片试图高度
    @IBOutlet weak var pictureViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        setupUI()
    }

}

extension ZlStutasPictureView {
    private func setupUI() {
        //1.cell中的控件要提前准备好
        //2.设置的时候  根据数据设置是否显示
        //3.不能动态的添加控件
        
        //超出的部分不显示
        clipsToBounds = true
        //创建循环 9个 imageView
        let count = 3
        let rect = CGRect(x: 0,
                          y: ZlStatusPictureViewOutterMargin,
                          width: ZlStatusPictureItemWidth,
                          height: ZlStatusPictureItemWidth)
        
        for i in 0..<9 {
            
            let iv = UIImageView()
            //设置 contentMode
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            //iv.backgroundColor = UIColor.red
            //行 -> y
            let row = CGFloat(i / count)
            //列 -> x
            let col = CGFloat(i % count)
            let xOffset = col * (ZlStatusPictureItemWidth + ZlStatusPictureViewInnerMargin)
            let yOffset = row * (ZlStatusPictureItemWidth + ZlStatusPictureViewInnerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            addSubview(iv)
        }
        
    }
}


