//
//  ZlOAuthViewController.swift
//  ZhylfWeibo
//
//  Created by 张彦林 on 2017/12/8.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import SVProgressHUD
// 通过 webView 展示微博的授权页面
class ZlOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        
        view = webView
        view.backgroundColor = UIColor.white
        //取消滚动试图--- 新浪的手机界面返回的就是手机全屏
        webView.scrollView.isScrollEnabled = false
        
        //设置代理
        webView.delegate = self
        //设置导航栏
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFull))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //记载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(ZlAppKey)&redirect_uri=\(ZlRedirectURI)"
        //1> 确定要访问的资源
        guard let url = URL(string: urlString) else {
            return
        }
        //2> 建立请求
        let request = URLRequest(url: url)
        //3> 加载请求
        webView.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - 监听方法
    ///关闭控制器
    @objc private func close (){
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
    /// 自动填充 -webView 的注入 直接通过js 修改 ‘本地浏览器中’ 缓存的页面内容
    /// 点击登录按钮  执行 submit（） 将本地数据交给服务器！
    @objc private func autoFull(){
        //准备JS 让webView执行Js
        let js = "document.getElementById('userId').value = '18682914529'; " + "document.getElementById('passwd').value = 'zhylf582729@';"
        
        webView.stringByEvaluatingJavaScript(from: js)
    }
}


extension ZlOAuthViewController: UIWebViewDelegate {
    
    /// webView 将要加载请求
    ///
    /// - Parameters:
    ///   - webView: webView
    ///   - request: 要加载的请求
    ///   - navigationType: 导航类型
    /// - Returns: Bool 是否加载request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //确认思路：
        //1.如果请求地址包含 http:zhangyanlf.cn 不加载页面 / 否则加载页面
        //request.url?.absoluteString.hasPrefix(ZlRedirectURI) 返回值是可选项 true/false/nil
        if request.url?.absoluteString.hasPrefix(ZlRedirectURI) == false {
            return true
        }
        
        //print("加载请求 --- \(String(describing: request.url?.absoluteString))")
        //query url ?后面的左右部分
           // print("加载请求 --- \(String(describing: request.url?.query))")
        //2. 从 http:zhangyanlf.cn 毁掉地址的查询字符串中查找 ”code=“
        if request.url?.query?.hasPrefix("code") == false {
            print("取消授权")
            close()
            
            return false
        }
        //3.从query 中取出授权码
        // 代码走到此处肯定包含查询字符串 并包含 “code=”
        /// 'substring(from:)' is deprecated: Please use String slicing subscript with a 'partial range from' operator.
        let code = request.url?.query?.substring(from: "code=".endIndex)
       
        
        
        print("获取授权码...\(String(describing: code))")
        //4.使用授权码获取 accessToken
        ZlNetworkManager.shared.loadAccessToken(code: code!) { (isSuccess) in
            if !isSuccess {
                SVProgressHUD.showInfo(withStatus: "网络请求失败")
            } else {
                SVProgressHUD.showInfo(withStatus: "登录成功")
                
                //登录成功后，通过跳转页面
                //1> 登录成功发送消息
                NotificationCenter.default.post(name: NSNotification.Name(UserLogoinSuccessedNotification),
                                                object: nil)
                //2> 关闭窗口
                self.close()
            }
        }
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}

