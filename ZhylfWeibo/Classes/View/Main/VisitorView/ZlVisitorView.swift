//
//  ZlVisitorView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/11/14.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

//访客试图
class ZlVisitorView: UIView {
    
    ///访客试图的信息字典 [imageName/message]
    /// 如果是首页 imageName = ""
    var vistorInfo: [String: String]? {
        didSet {
        
            //1> 取字典信息
            guard let imageName = vistorInfo?["imageName"],
                let message = vistorInfo?["message"] else {
                    return
            }
            //2> 设置消息
            tipLabel?.text = message
            
            //3>设置图像  首页不需要设置
            if imageName == "" {
                startAnimation()
                return
                
            }
            
            iconView.image = UIImage(named: imageName)
            //其他控制器的访客试图不显示小房子
            houseView.isHidden = true
            //遮罩试图隐藏
            maskIconView.isHidden = true
            
        }
    }
    
    //旋转图标动画
    private func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        //完成之后不删除
        anim.isRemovedOnCompletion = false
        
        //将动画添加到图层
        iconView.layer.add(anim, forKey: nil)
        
    }
    

    //MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    //MARK: - 私有控件
    ///图像试图
    private lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    //遮罩试图
    private lazy var maskIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    ///小房子
    private lazy var houseView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    ///提示标签
    private lazy var tipLabel = UILabel.cz_label(withText: "关注一些人,回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGray)
    ///注册按钮
    private lazy var registerBtn = UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white")
    
    ///登录按钮
   private lazy var logonBtn = UIButton.cz_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white")
    
}

extension ZlVisitorView {
    func setupUI() {
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        //1.添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseView)
        addSubview(tipLabel!)
        addSubview(registerBtn!)
        addSubview(logonBtn!)
        
        //文本集中
        tipLabel?.textAlignment = .center
        
        //2. 取消 autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        //3.自动布局
        //1>图像试图
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0, constant: -60))
        //2>小房子
        addConstraint(NSLayoutConstraint(item: houseView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0, constant: 0))
        //3.提示Label
        addConstraint(NSLayoutConstraint(item: tipLabel!,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel!,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        addConstraint(NSLayoutConstraint(item: tipLabel!,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        //4注册按钮
        addConstraint(NSLayoutConstraint(item: registerBtn!,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn!,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: registerBtn!,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        //5登录按钮
        addConstraint(NSLayoutConstraint(item: logonBtn!,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: logonBtn!,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: logonBtn!,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        //6.遮罩试图
        //views ：定义VFL 中的控件名称和实际名称的映射关系
        //metrics : 定义VFL  用()指定的常数映射关系
        
        let viewDic = ["maskIconView": maskIconView,"registerBtn": registerBtn!] as [String : Any]
        let metrics = ["spacing": -20]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskIconView]-0-|",
            options: [],
            metrics: nil,
            views: viewDic))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerBtn]",
            options: [],
            metrics: metrics,
            views: viewDic))
        
    }
}




