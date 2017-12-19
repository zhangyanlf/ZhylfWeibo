//
//  UIImageView+WebImage.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/18.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import SDWebImage

extension UIImageView {
    /// 隔离 SDWebImage 设置图像
    ///
    /// - Parameters:
    ///   - urlString:          url
    ///   - placeholderImage:   placeholderImage
    ///   - isAvatar:           是否头像
    func zl_setupImage(urlString: String?,placeholderImage: UIImage?,isAvatar: Bool = false) {
        //处理Url
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
             image = placeholderImage
            return
        }
        //可选项只是用在swift OC 有的时候用 ！同样可以传入nil
        sd_setImageWithPreviousCachedImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) {[weak self] (image, _, _, _) in
            
            //完成回调 - 判断是否是头像
            if isAvatar {
               self?.image = image?.zl_avatarImage(size: self?.bounds.size)
            }
            
            
        }
    }
}
