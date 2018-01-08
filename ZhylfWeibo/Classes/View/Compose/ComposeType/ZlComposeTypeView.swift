//
//  ZlComposeTypeView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/29.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

/// 撰写微博类型试图
class ZlComposeTypeView: UIView {
    ///滚动试图
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
    }
    

    
   
    /// 关闭试图
    @IBAction func closeButton(_ sender: UIButton) {
        removeFromSuperview()
    }
    
   @objc private func clickItem() {
        print("点我了")
    }
    
    /// 点击更多按钮
   @objc private func clickMore() {
        print("点击更多")
    }
    
}


///private 让 extension 中所有的方法都是私有
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
