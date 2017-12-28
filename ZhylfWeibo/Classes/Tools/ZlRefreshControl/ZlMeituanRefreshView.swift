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
        
        
        
    }
}
