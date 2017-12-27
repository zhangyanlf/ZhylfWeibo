//
//  ZlRefreshControl.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/27.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
/// 刷新状态切换的临界点
private let ZlRefreshOffset: CGFloat = 60

/// 刷新状态
///
/// - Normal: 普通状态什么都不做
/// - Pulling: 超过临界点 如果放手 开始刷新
/// - WillRefresh: 用户超过临界点并且放手
enum ZlRefreshState {
    case Normal
    case Pulling
    case WillRefresh
}

/// 刷新控件 -- 负责刷新相关的逻辑处理
class ZlRefreshControl: UIControl {
    //MARK: - 属性
    //刷新控件的父试图 下拉刷新控件应该适用于 UItableView/UICollectionView
    private weak var scrollView: UIScrollView?
    
    /// 刷新试图
    private lazy var refreshView: ZlRefreshView = ZlRefreshView.refreshView()
    
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
        
        if height < 0 {
            return
        }
        
        //根据高度设置刷新控件的 fream
        self.frame = CGRect(x: 0,
                            y: -height,
                            width: sv.bounds.width,
                            height: height)
        
        //判断临界点  - 只需要判断一次
        if sv.isDragging {
            if height > ZlRefreshOffset && (refreshView.refreshState == .Normal) {
                print("放手刷新")
                refreshView.refreshState = .Pulling
            } else if height <= ZlRefreshOffset && (refreshView.refreshState == .Pulling)  {
                print("继续在使劲拉...")
                refreshView.refreshState = .Normal
            }
        } else {
            //放手 - 是否超过临界点
            if refreshView.refreshState == .Pulling {
                print("准备开始刷新")
                
                //刷新结束之后将状态改为normal 才能继续响应刷新
                refreshView.refreshState = .WillRefresh
            }
        }
        
        
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
        //设置超出边界不显示
        clipsToBounds = true
        //添加刷新试图 - 从xib架子啊出来 默认就是 xib 中指定的宽高
        addSubview(refreshView)
        
        //自动布局 - 设置xib 控件的自动布局 需要制定宽高约束
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))
    }
}

