//
//  ZlNewFeatureView.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/13.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
//新特性界面
class ZlNewFeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    /// 点击按钮
    ///
    /// - Parameter sender: Any
    @IBAction func startButton(_ sender: Any) {
        removeFromSuperview()
    }

    class func newFeatureView() -> ZlNewFeatureView {
        
        let nib = UINib(nibName: "ZlNewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! ZlNewFeatureView
        // 从XIB 加载的试图 默认是 600 * 600
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
    override func awakeFromNib() {
        //使用自动布局 11以前加载 XIb 的大小是 600 * 600  11以后为屏幕大小
        print(bounds)
        //添加4和试图
        let count = 4
        let rect = UIScreen.main.bounds
        
        for i in 0..<count {
            let imageName = "new_feature_\(i + 1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            //设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            //添加到scrollView
            scrollView.addSubview(iv)
            
        }
        //指定滚动试图的属性
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        //隐藏按钮
        startButton.isHidden = true
    }

}

extension ZlNewFeatureView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //1.滚动到最后一屏 让试图删除
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        //判断是否是最后一页
        if page == scrollView.subviews.count {
            print("进入试图")
            self.removeFromSuperview()
        }
        //如果是倒数第二页  显示按钮
         startButton.isHidden = (page != scrollView.subviews.count - 1)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //一滚动就隐藏按钮
        startButton.isHidden = true
        //1.计算当前的偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        //2.设置分页控件
        pageControl.currentPage = page
        //3.分页控件隐藏
        pageControl.isHidden = (page == scrollView.subviews.count)
    }
}
