//
//  ZlStatusCell.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/15.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZlStatusCell: UITableViewCell {

    ///微博试图模型
    var viewModel: ZlStatusViewModel? {
        didSet {
            //微博文本
            statusLabel?.text = viewModel?.status.text
            //用户名称
            nameLabel.text = viewModel?.status.user?.screen_name as! String
            //设置会员图标
            vipIconView.image = viewModel?.vipmberIcon
            //认证图标
            memberIconView.image = viewModel?.memberIcon
            //用户图像
            iconView.zl_setupImage(urlString: viewModel?.status.user?.profile_image_url as! String, placeholderImage: UIImage(named: "avatar_default_big"),isAvatar: true)
            ///底部工具栏
            toolBar.viewModel = viewModel
            
            //配图试图试图模型
            pictureView.viewModel = viewModel
            ///测试修改配置试图的高度
           // pictureView.pictureViewHeight.constant = viewModel?.pictureViewSize.height ?? 0
            
        
            //FIXME: 4张图片处理
            
//             let count = viewModel?.status.pic_urls?.count
//             if (count! > 4) {
//             //修改数量 -> 将末尾的数据全部删除
//             var pic_Urls = viewModel!.status.pic_urls!
//             pic_Urls.removeSubrange((pic_Urls.startIndex + 4)..<pic_Urls.endIndex)
//             pictureView.urls = pic_Urls
//             } else {
//             pictureView.urls = viewModel?.status.pic_urls
//             }
            
            ///设置配图是的 URL 数据 (包含了被转发和原创)
            //pictureView.urls = viewModel?.pic_Urls
            ///设置微博转发正文文字
            retweetedLabel?.text = viewModel?.retweetedText as String?


        }
    }
    
    /// 用户头像
    @IBOutlet weak var iconView: UIImageView!
    
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    
    /// 认证图标
    @IBOutlet weak var memberIconView: UIImageView!
    
    /// 会员图片
    @IBOutlet weak var vipIconView: UIImageView!
    
    /// 发布时间
    @IBOutlet weak var timeLabel: UILabel!
    
    /// 来源
    @IBOutlet weak var sourceLabel: UILabel!
    
    /// 正文
    @IBOutlet weak var statusLabel: UILabel!
    
    /// 底部bar
    @IBOutlet weak var toolBar: ZlStatusToolBar!
     /// 配图试图
     @IBOutlet weak var pictureView: ZlStutasPictureView!
    /// 被转发微正文 - 原创微博没有此控件 一定要用 ？
    @IBOutlet weak var retweetedLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        ///离屏渲染  -- 异步加载
        self.layer.drawsAsynchronously = true
        ///栅格化 -- 异步绘制之后会生成一张独立的图像 cell在屏幕上滚动的时候 实际上是滚动这张图片
        ///Cell 优化 尽量减少图层的数量 -- 这样就相当于一层
        ///停止滚动后 可以接受监听
        self.layer.shouldRasterize = true
        
        ///使用栅格化 必须制定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    

}
