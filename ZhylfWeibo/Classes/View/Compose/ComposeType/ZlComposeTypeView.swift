//
//  ZlComposeTypeView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/29.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import pop
/// 撰写微博类型试图
class ZlComposeTypeView: UIView {
    ///滚动试图
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backButton: UIButton!
    ///返回按钮的YConstraint
    @IBOutlet weak var backButtonConstraint: NSLayoutConstraint!
    ///关闭按钮按钮的YConstraint
    @IBOutlet weak var closeButtonConstraint: NSLayoutConstraint!
    /// 按钮数据数组
    private let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "ZlComposeViewController"],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                               ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                               ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                               ["imageName": "tabbar_compose_music", "title": "音乐"],
                               ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
    ]
    class func composeTypeView() ->ZlComposeTypeView {
        
        let nib = UINib(nibName: "ZlComposeTypeView", bundle: nil)
        //XIB 加载完成试图  就会调用awakeFromNib
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! ZlComposeTypeView
        
        v.frame = UIScreen.main.bounds
        v.setupUI()
        
        return v
    }
    
    /// 显示当前试图
    func show() {
        //1> 将当前视图添加到 根试图控制器的 view
       guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        //2> 添加试图
        vc.view.addSubview(self)
        //3> 添加动画
        showCarrentView()
        
    }
    

    
   
    /// 关闭试图
    @IBAction func closeButton(_ sender: UIButton) {
        hidenButtons()
        //removeFromSuperview()
        
    }
    
    
    /// 返回第一页
    @IBAction func backButton(_ sender: Any) {
        //滚动试图滚动到第一页
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        closeButtonConstraint.constant = 0
        backButtonConstraint.constant = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
            self.backButton.alpha = 0
        }) { (_) in
            self.backButton.isHidden = true
            self.backButton.alpha = 1
        }
       
    }
    
   @objc private func clickItem() {
        print("点我了")
    }
    
    /// 点击更多按钮
   @objc private func clickMore() {
        print("点击更多")
        //1.滚动scrollView 第二页
    
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: true)
        //2.处理底部按钮
        backButton.isHidden = false
    
        let margin = scrollView.bounds.width / 6
        closeButtonConstraint.constant += margin
        backButtonConstraint.constant -= margin
    
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    
    }
    
}

// MARK: - 动画方法扩展
private extension ZlComposeTypeView {
    ///MARK: - 消除动画
    private func hidenButtons() {
        //根据 contentOffset 判断当前显示的子试图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        //2.遍历v中的所有按钮
        for (i,btn) in v.subviews.enumerated().reversed() {//reversed 反向
            //1.设置动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            //2.设置动画属性
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 400
            
            //设置时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i) * 0.025
            
            //3.添加动画
            btn.pop_add(anim, forKey: nil)
            //监听第 0 个按钮动画 是最后一个执行的
            if i == 0 {
                anim.completionBlock = {_,_ in
                    self.hideCarrentView()
                }
            }
            
        }
        
        //隐藏当前视图 - 开始时间
       
        
    }
    
    /// 隐藏当前视图
    private func hideCarrentView(){
        //1> 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25
        
        //2>添加动画
        pop_add(anim, forKey: nil)
        //3> 添加监听完成方法
        anim.completionBlock = {_,_ in
            self.removeFromSuperview()
        }
        
    }
    
    ///MARK: - 显示部分的动画
    //动画显示当前视图
    private func showCarrentView() {
        //1.创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.25
        
        //2> 添加到试图
        pop_add(anim, forKey: nil)
        //3> 添加按钮动画
        showButtons()
    }
    
    private func showButtons(){
        //1.获取ScrollView的第0个试图
        let v = scrollView.subviews[0]
        //2.遍历v的所有按钮
        for (i,btn) in v.subviews.enumerated() {
            
            //1.创建动画
            let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            //2.动画属性
            anim.fromValue = btn.center.y + 400
            anim.toValue = btn.center.y
            
            //弹力系数 取值范围 0-20 数值越大 弹性越大 默认值为4
            anim.springBounciness = 8
            //弹力速度 取值范围 0-20 数值越大 速度越快 默认值12
            anim.springSpeed = 8
            
            //设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            
            //3.添加动画
            btn.pop_add(anim, forKey: nil)
            
        }
        
    }
}

//MARK: - private 让 extension 中所有的方法都是私有
private extension ZlComposeTypeView {
    func setupUI() {
        //强行更新布局
        layoutIfNeeded()
      //1.向ScrollView添加试图
        let rect = scrollView.bounds
        let width = scrollView.bounds.width
        
        for i in 0..<2 {
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            //2.向试图添加按钮
            addButtons(v: v, idx: i * 6)
            
            scrollView.addSubview(v)
        }
        
        //设置scrollView
        scrollView.contentSize = CGSize(width: 2 * width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        //设置滚动试图不滚动
        scrollView.isScrollEnabled = false
    
        
     
    }
    
    /// 向 v 中添加按钮 按钮的顺序就从 idx 开始
    func addButtons(v: UIView,idx: Int) {
        //从idx开始添加留个按钮
        let count = 6
        
        for i in idx..<(idx + count) {
            if i >= buttonsInfo.count {
                break
            }
            
            //0.从数组按钮中获取按钮图片名称及title
            let dict = buttonsInfo[i]
            guard let imageName = dict["imageName"],
                let title = dict["title"] else {
                continue
            }

            //1.创建按钮
            let btn = ZlComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            
            //2.将btn添加到试图
            v.addSubview(btn)
            
            //3.添加监听方法
            if let actionName = dict["actionName"] {
                
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
            
            
           }
            
            //遍历试图的自试图  布局按钮
            // 准备常量
            let btnSize = CGSize(width: 100, height: 100)
            let margin = (v.bounds.width - 3 * btnSize.width) / 4
            
            
            
            for (i, btn) in v.subviews.enumerated() {
                
                let y:CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
                let col = i % 3
                
                let x = CGFloat(col + 1) * margin + CGFloat(col) * btnSize.width
                
                btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
           
        }
        
    }
    
}
