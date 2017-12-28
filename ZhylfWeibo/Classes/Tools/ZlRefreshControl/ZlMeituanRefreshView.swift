//
//  ZlMeituanRefreshView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/28.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlMeituanRefreshView: ZlRefreshView {
    

    @IBOutlet weak var buildingIconView: UIImageView!
    
    @IBOutlet weak var earthIconView: UIImageView!
    
    @IBOutlet weak var kangarooIconView: UIImageView!
    
    /// 父试图高度
   override var parentViewHeight: CGFloat {
        didSet {
            print("设置父试图高度\(parentViewHeight)")
            
            if parentViewHeight < 23{
                return
            }
            // 23 -> 126
            //0.2 -> 1
            //高度差 / 最大高度差
            //23 == 1 -> 0.2
            //ZlRefreshOffset == 0 -> 1
            var scale: CGFloat
            
            if parentViewHeight > ZlRefreshOffset {
                scale = 1
            } else {
                scale = 1 - ((ZlRefreshOffset - parentViewHeight) / (ZlRefreshOffset - 23))
            }
            kangarooIconView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    
    override func awakeFromNib() {
        //1.设置房子
        let bImage1 = #imageLiteral(resourceName: "icon_building_loading_1")
        let bImage2 = #imageLiteral(resourceName: "icon_building_loading_2")
        buildingIconView.image = UIImage.animatedImage(with: [bImage1,bImage2], duration: 0.5)
        //2.地球旋转
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = -2 * Double.pi
        animation.repeatCount = MAXFLOAT
        animation.duration = 3
        
        animation.isRemovedOnCompletion = false
        earthIconView.layer.add(animation, forKey: nil)
        
        //3.设置袋鼠动画
        //0> 设置动画
        let kImage1 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_1")
        let kImage2 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_2")
        buildingIconView.image = UIImage.animatedImage(with: [kImage1,kImage2], duration: 0.5)
        //1>设置锚点
        kangarooIconView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        //2>设置 center
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - 24
        
        kangarooIconView.center = CGPoint(x: x,
                                          y: y)
        
        kangarooIconView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
       
        
        
        
    }
}
