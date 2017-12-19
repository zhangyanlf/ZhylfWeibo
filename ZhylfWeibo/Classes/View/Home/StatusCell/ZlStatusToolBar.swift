//
//  ZlStatusToolBar.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/19.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlStatusToolBar: UIView {
    
    var viewModel: ZlStatusViewModel? {
        didSet {
//            retweetButton.setTitle("\(String(describing: viewModel?.status.reposts_count))", for: .normal)
//            criticismButton.setTitle("\(String(describing: viewModel?.status.comments_count))", for: .normal)
//            likeButton.setTitle("\(String(describing: viewModel?.status.attitudes_count))", for: .normal)
            retweetButton.setTitle(viewModel?.retweetStr, for: .normal)
            criticismButton.setTitle(viewModel?.commentsStr, for: .normal)
            likeButton.setTitle(viewModel?.attitudesStr, for: .normal)
        }
    }
    

     /// 转发
     @IBOutlet weak var retweetButton: UIButton!
     /// 评论
     @IBOutlet weak var criticismButton: UIButton!
     /// 赞
     @IBOutlet weak var likeButton: UIButton!

}
