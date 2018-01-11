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
            nameLabel.text = viewModel?.status.user?.screen_name as String?
            //设置会员图标
            vipIconView.image = viewModel?.vipmberIcon
            //认证图标
            memberIconView.image = viewModel?.memberIcon
            //用户图像
            iconView.zl_setupImage(urlString: viewModel?.status.user?.profile_image_url as String?, placeholderImage: UIImage(named: "avatar_default_big"),isAvatar: true)
            ///底部工具栏
            toolBar.viewModel = viewModel
            
            //配图试图试图模型
            pictureView.viewModel = viewModel
            ///测试修改配置试图的高度
            // pictureView.pictureViewHeight.constant = viewModel?.pictureViewSize.height ?? 0
            
        
            //FIXME: 4张图片处理
            
             //let count = viewModel?.status.pic_urls?.count
             //if (count! > 4) {
             //修改数量 -> 将末尾的数据全部删除
             //var pic_Urls = viewModel!.status.pic_urls!
             //pic_Urls.removeSubrange((pic_Urls.startIndex + 4)..<pic_Urls.endIndex)
             //pictureView.urls = pic_Urls
             //} else {
             //pictureView.urls = viewModel?.status.pic_urls
             //}
            
            ///设置配图是的 URL 数据 (包含了被转发和原创)
            //pictureView.urls = viewModel?.pic_Urls
            ///设置微博转发正文文字
            retweetedLabel?.text = viewModel?.retweetedText as String?
            
            //<a href="http://app.weibo.com/t/feed/6vtZb0" rel="nofollow">微博 weibo.com</a>
            //1.目标  取出url连接 及 文本描述
            //let str = viewModel?.status.source as String?
            //let result = "来自 " + (str?.zl_href()?.text)!
            
            //设置来源（viewModel设置会开辟控件）
            //sourceLabel.text = viewModel?.sourceStr as String?
            //didSet中给source 再次设置值  不会再调用didSet
            sourceLabel.text = viewModel?.status.source as String?

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
        /*
        ///离屏渲染  -- 异步加载
        self.layer.drawsAsynchronously = true
        ///栅格化 -- 异步绘制之后会生成一张独立的图像 cell在屏幕上滚动的时候 实际上是滚动这张图片
        ///Cell 优化 尽量减少图层的数量 -- 这样就相当于一层
        ///停止滚动后 可以接受监听
        self.layer.shouldRasterize = true
        
        ///使用栅格化 必须制定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
         */
    }

    func regx() {
        let str = "<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>"
        //2.创建正则表达式
        //pattern -> 匹配方案
        //索引
        //0 和匹配方案完全一致的字符串
        //1 第一个()中的内容
        //2 第二个()中的内容
        //对于模糊匹配 如果关心的内容就用(.*?)表示 然后根据索引可以得到结果
        //如果不关心的结果用 .*? 可以匹配任意的内容
        let pattern = "<a href=\"(.*?)\" .*?>(.*?)</a>"
        //创建正则表达式 如果 pattern 失败  会抛出异常
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return
        }
        
        //进行查找 两种超查找方法
        //只找第一个匹配项/多个匹配项
        guard let result = regx.firstMatch(in: str, options: [], range: NSRange(location: 0, length:str.characters.count)) else {
            print("没有找到匹配项")
            return
        }
        
        //只有两个重要的方法
        //result.numberOfRanges ->查找到的范围数量
        //result.range(at: idx) ->指定索引位置的范围
        print(result)
    }

}
