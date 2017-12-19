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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
