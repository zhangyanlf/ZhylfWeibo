# ZhylfWeibo

# 2017-11-15 项目框架搭建完成，小结：
# ![image](https://github.com/zhangyanlf/ZhylfWeibo/blob/master/ZhylfWeibo/Classes/zhangyanlf/基本架构流程图.png)

# 首页动画效果

#### 旋转图标动画
```
 private func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        //完成之后不删除
        anim.isRemovedOnCompletion = false
        
        //将动画添加到图层
        iconView.layer.add(anim, forKey: nil)
        
    }
```
####  anim.isRemovedOnCompletion = false  动画执行完后不删除  不写时会引起动画执行一个周期/界面切换后停止动画效果


# 网络小结：
 ![image](https://github.com/zhangyanlf/ZhylfWeibo/blob/master/ZhylfWeibo/Classes/zhangyanlf/网络框架.png)
 
 ##  AFNetworking 封装网络请求
 ```
 ///封装AF 的 Get /Post
    ///
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调 json(字典/数组，是否成功)
    func request(method: ZlHTTPMethod = .GET, URLString: String,parameters:[String:AnyObject]?,completion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()) {


        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: { (task, json) in
                completion(json as AnyObject, true)
            }, failure: { (task, error) in

                print("网络请求错误\(error)")
                completion(nil, false)
            })
        }else{
            post(URLString, parameters: parameters, progress: nil, success: { (_, json) in
                completion(json as AnyObject, true)
            }, failure: { (task, error) in
                print("网络请求错误\(error)")
                completion(nil, false)
            })
        }
    }
 ```
 
 ##  Alamofire 封装网络请求
 ```
 func getRequest(method: ZlHTTPMethod = .GET,urlString: String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        //使用Alamofire进行网络请求时，调用该方法的参数都是通过getRequest(urlString， params, success :, failture :）传入的，而success传入的其实是一个接受           [String : AnyObject]类型 返回void类型的函数
        
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { (response) in/*这里使用了闭包*/
                //当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
                //使用switch判断请求是否成功，也就是response的result
                switch response.result {
                case .success(let value):
                    //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                    // if let value = response.result.value as? [String: AnyObject] {
                    success(value as! [String : AnyObject])
                    //                    }
                   print(value)
                    
                case .failure(let error):
                    failture(error)
                    print("error:\(error)")
                }
        }
        
    }
 ```
# 首页cell显示小结：

## cell显示
 ![image](https://github.com/zhangyanlf/ZhylfWeibo/blob/master/ZhylfWeibo/Classes/zhangyanlf/cell.png)

## 被转发Cell：
 ![image](https://github.com/zhangyanlf/ZhylfWeibo/blob/master/ZhylfWeibo/Classes/zhangyanlf/被转发Cell.png)
 
## 单张图片等比例显示：
  ![image](https://github.com/zhangyanlf/ZhylfWeibo/blob/master/ZhylfWeibo/Classes/zhangyanlf/单图等比例显示.png)
 
##关于表格试图性能优化：

 - 尽量少计算， 所有需要的素材提前计算好
 - 控件不要设置圆角半径  图片渲染的属性都要注意
 - 不要动态创建组件  所有需要的控件 都要提前创建好 在现实的时候 根据数据显示/隐藏
 - cell中控件的数量越少越好
 - 要测量 不要猜测
 
 ### 在Cell存在头像或者图片需要使用圆角功能是，尽量少用layer.cornerRadiusla来设置图片的圆角，这样会大量占用CPU影响tableView的性能，尽可能去使用路径裁切功能设置图片的圆角，代码如下:
 
 ```
 extension UIImage{
    
    /// 创建图片，圆角
    ///
    /// - Parameters:
    ///   - size: 尺寸
    ///   - backColor: 背景色
    /// - Returns: 裁切后的图像
    func zl_avatarImage(size:CGSize?,backColor:UIColor = UIColor.white,lineColor:UIColor = UIColor.lightGray) -> UIImage? {
        var size = size
        if size == nil {
            size = self.size
        }
        let rect  = CGRect(origin: CGPoint(), size: size!)
        
        /*
         1>size
         2>不透明 (混合) png图片支持透明 jpg 图形不支持透明
         3>屏幕分辨率 如果不指定，默认使用1.0的分辨率（图片质量不好）
         指定0，会选择当前设备屏幕的分辨率
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        // 圆角
        // （0） 背景填充
        backColor.setFill()
        UIRectFill(rect)
        // （1） 原型路径
        let path = UIBezierPath(ovalIn: rect)
        // （2） 路径裁切
        path.addClip()
        // 2 绘图
        draw(in: rect)

        // 绘制内切原型
        let ovaPath = UIBezierPath(ovalIn: rect)
        
        lineColor.setStroke()
        
        ovaPath.lineWidth = 2
        
        ovaPath.stroke()
        
        // 3 取得新的图像
        let result = UIGraphicsGetImageFromCurrentImageContext()
        // 4 关闭上下文
        UIGraphicsEndImageContext()
        // 5 返回结果
        return result
        
    }
    
}

 ```


 
