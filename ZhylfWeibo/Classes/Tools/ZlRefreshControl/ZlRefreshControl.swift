//
//  ZlRefreshControl.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/27.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

/// 刷新控件
class ZlRefreshControl: UIControl {
    //MARK: - 属性
    //刷新控件的父试图 下拉刷新控件应该适用于 UItableView/UICollectionView
    private weak var scrollView: UIScrollView?
    
    /// MARK: - 构造函数
    init() {
        super.init(frame: CGRect())
        
        setupUI()
    }
    /**
      willMove newSuperview 方法会调用
        - 当添加到父试图的时候 newSuperview 是父试图
        - 当父试图被移除 newSuperview 是nil
     */
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
//        print(newSuperview!)
        //判断父试图类型
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        //记录父试图
        scrollView = sv
        //KVO 监听父试图 contentOffset  (谁监听谁负责)
        //在程序中 通常只监听一个对象的某几个属性  如果属性太多 会很乱
        //观察者模式 在不需要的时候 都要释放
        //  - 通知中心: 如果不释放 什么也不会发生 但会存在内存泄漏 及 多次注册的可能！
        //  - KVO: 如果不释放  会崩溃
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
       
    }
    //本试图从父试图上移除
    // : 所有下拉刷新都是监听 contentOffset
    override func removeFromSuperview() {
        //superview 还存在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
        //superview 不存在
    }
    //所有KVO方法会统一调用此方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //contentOffset 的 y 值跟 contentInset 的 top 有关
        //print(scrollView?.contentOffset)
        guard let sv = scrollView else {
            return
        }
        //初始化高度应该是 0
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        
        //根据高度设置刷新控件的 fream
        self.frame = CGRect(x: 0,
                            y: -height,
                            width: sv.bounds.width,
                            height: height)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 开始刷新
    func beginRefreshing (){
        
    }
    
    /// 结束刷新
    func endRefreshing () {
        
    }

}

extension ZlRefreshControl {
    private func setupUI () {
        backgroundColor = UIColor.orange
    }
}

