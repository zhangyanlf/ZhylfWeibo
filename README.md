# ZhylfWeibo

# 2017-11-15 项目框架搭建完成，小结：
# ![image](https://github.com/zhangyanlf/ZhylfWeibo/blob/master/ZhylfWeibo/Classes/zhangyanlf/基本架构流程图.png)

# 首页动画效果

# 旋转图标动画
# 
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
#  anim.isRemovedOnCompletion = false  动画执行完后不删除  不写时会引起动画执行一个周期/界面切换后停止动画
