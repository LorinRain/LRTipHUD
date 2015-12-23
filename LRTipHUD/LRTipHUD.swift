//
//  LRTipHUD.swift
//  LRTipHUD
//
//  Created by Lorin on 15/12/11.
//  Copyright © 2015年 LorinRain. All rights reserved.
//  提示框

import UIKit

class LRTipHUD: UIView {
    
    // MARK: - 定义部分
    /**
    * Define Part
    * 定义
    */
    ///屏幕宽度
    private let SCREENWIDTH = UIScreen.mainScreen().bounds.size.width
    
    ///屏幕高度
    private let SCREENHEIGHT = UIScreen.mainScreen().bounds.size.height
    
    ///视图与屏幕两侧间距
    let SCREENMARGIN: CGFloat = 20
    
    ///内部文字与视图两端间距
    let TEXTVIEWMARGIN: CGFloat = 25
    
    ///标题与视图上端间距
    let TITLETOPMARGIN: CGFloat = 15
    
    ///内容与视图下端间距
    let CONTENTBOTTOMMARGIN: CGFloat = 25
    
    ///标题与内容间距
    let TITLECONTENTMARGIN: CGFloat = 20
    
    ///标题文字字体
    let titleFont = UIFont.boldSystemFontOfSize(16)
    
    ///内容文字字体
    let contentFont = UIFont.systemFontOfSize(14)
    
    
    // MARK: - 开放API
    /*
    * Puvlic API Part
    * 开放api
    */
    /** hud颜色
    * Default is whiteColor
    * 默认为白色
    */
    var hudBackgroundColor: UIColor = UIColor.whiteColor()
    
    /** 是否蒙版背景
    * Default is false, when set to true, view will set async property to false, so that other actions can not responed
    * 默认为否，当设置为true的时候，默认会将async设置为false，即在显示Hud的时候不能进行其他操作
    */
    var hudIsDimBackground: Bool = false
    
    /** 标题
    * Default is nil
    * 默认为空
    */
    var hudTitle: String? = nil
    
    /** 提示内容
    * can not be nil
    * 不能为空
    */
    var hudText: String = ""
    
    /** 是否圆角
    * Default is true
    * 默认为圆角
    */
    var hudIsFillet: Bool = true
    
    /** 圆角角度，仅当hudIsFillet属性为true的情况下有效
    * Only work when hudIsFillet is true, defaut is 5
    * 默认为5
    */
    var hudCornerRadius: CGFloat = 5
    
    /** 标题颜色
    * Default is blackColor
    s* 默认为黑色
    */
    var hudTitleColor: UIColor = UIColor.blackColor()
    
    /** 内容颜色
    * Default is black
    * 默认是黑色
    */
    var hudTextColor: UIColor = UIColor.blackColor()
    
    /** 是否自动消失
    * Default is false
    * 默认为否
    */
    var hudIsAutoDismiss: Bool = false
    
    /** 自动消失时间，仅当hudIsAutoDismiss属性为true的情况下有效
    * Only work when hudIsAutoDismiss is true, default is 1.5
    * 默认为1.5秒
    */
    var hudAutoDismissTime: Double = 1.5
    
    /** 显示时能否进行其他操作
    * Default is true
    * 默认为可以进行其他操作
    */
    var hudIsAsync: Bool = true
    
    /** 竖直方向偏移量
    * Default is 0
    * 默认为0
    */
    var hudYOffSet: CGFloat = 0
    
    /** 水平方向偏移量
    * Default is 0
    * 默认为0
    */
    var hudXOffSet: CGFloat = 0
    
    // MARK: - 私有方法
    /**
    * Private Method Part
    * 私有函数部分
    */
    ///计算标题尺寸
    private func caculateTitleSize(title: String) -> CGSize {
        // 计算标题的尺寸
        let titleStr = NSString(string: title)
        let titleStrRect = titleStr.boundingRectWithSize(CGSizeMake(SCREENWIDTH - SCREENMARGIN*2 - TEXTVIEWMARGIN*2, SCREENHEIGHT - CONTENTBOTTOMMARGIN*2), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: titleFont], context: nil)
        
        return titleStrRect.size
    }
    
    ///计算内容尺寸
    private func caculateContentSize(content: String) -> CGSize {
        let contentStr = NSString(string: content)
        let contentStrRect = contentStr.boundingRectWithSize(CGSizeMake(SCREENWIDTH - SCREENMARGIN*2 - TEXTVIEWMARGIN*2, SCREENHEIGHT - CONTENTBOTTOMMARGIN*2), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: contentFont], context: nil)
        
        return contentStrRect.size
    }
    
    ///计算视图宽度
    private func caculateWidth(title: String?, tips: String) -> CGFloat {
        // 如果没有标题，则返回内容宽度
        if title == nil {
            return (caculateContentSize(tips).width + TEXTVIEWMARGIN*2)
        } else {
            
            if caculateTitleSize(title!).width > caculateContentSize(tips).width {
                return (caculateTitleSize(title!).width + TEXTVIEWMARGIN*2)
            } else {
                return (caculateContentSize(tips).width + TEXTVIEWMARGIN*2)
            }
            
        }
    }
    
    ///计算视图高度
    private func caculateHeight(title: String?, tips: String) -> CGFloat {
        
        if title == nil {
            return (caculateContentSize(tips).height + CONTENTBOTTOMMARGIN*2)
        } else {
            return (caculateTitleSize(title!).height + TITLETOPMARGIN + TITLECONTENTMARGIN + caculateContentSize(tips).height + CONTENTBOTTOMMARGIN)
        }
    }
    
    ///初始化提示框
    private func initHud() -> UIView {
        // 1.计算视图尺寸
        let tipView = UIView()
        tipView.center = CGPointMake(SCREENWIDTH*0.5 + self.hudXOffSet, SCREENHEIGHT*0.5 + self.hudYOffSet)
        tipView.bounds = CGRectMake(0, 0, self.caculateWidth(self.hudTitle, tips: self.hudText), self.caculateHeight(self.hudTitle, tips: self.hudText))
        
        // 设置视图背景颜色
        tipView.backgroundColor = self.hudBackgroundColor
        
        // 设置圆角
        if self.hudIsFillet {
            tipView.layer.cornerRadius = self.hudCornerRadius
            tipView.layer.masksToBounds = true
        }
        
        // 2.添加标题
        if self.hudTitle != nil {
            let titleLabel = UILabel()
            titleLabel.frame = CGRectMake(TEXTVIEWMARGIN, TITLETOPMARGIN, tipView.bounds.size.width - TEXTVIEWMARGIN*2, caculateTitleSize(self.hudTitle!).height)
            
            // 设置属性
            titleLabel.font = titleFont
            titleLabel.textAlignment = .Center
            titleLabel.text = self.hudTitle
            titleLabel.textColor = self.hudTitleColor
            
            tipView.addSubview(titleLabel)
        }
        
        // 3.添加内容
        ///内容的top
        let contenOriginY: CGFloat
        
        if self.hudTitle == nil {
            contenOriginY = CONTENTBOTTOMMARGIN
        } else {
            contenOriginY = TITLETOPMARGIN + caculateTitleSize(self.hudTitle!).height + TITLECONTENTMARGIN
        }
        
        let contentLabel = UILabel()
        contentLabel.frame = CGRectMake(TEXTVIEWMARGIN, contenOriginY, tipView.bounds.size.width - TEXTVIEWMARGIN*2, caculateContentSize(self.hudText).height)
        
        // 设置属性
        contentLabel.font = contentFont
        contentLabel.textAlignment = .Center
        contentLabel.text = self.hudText
        contentLabel.numberOfLines = 0
        contentLabel.textColor = self.hudTextColor
        
        tipView.addSubview(contentLabel)
        
        // 判断是否有蒙版背景
        // 此处，当设置有蒙版背景的时候，async属性自动设置为false
        if self.hudIsDimBackground {
            self.backgroundColor = UIColor(white: 0, alpha: 0.3)
            self.hudIsAsync = false
        } else {
            self.backgroundColor = UIColor.clearColor()
        }
        
        // 判断在显示hud的时候是否能进行其他操作，根据是否能进行其他操作来设置自身尺寸
        if self.hudIsAsync {
            // 可以的话，视图的大小即为hud的大小
            self.center = tipView.center
            self.bounds = tipView.bounds
            
            // 重新计算tipView的位置
            tipView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)
        } else {
            // 非异步，则视图为全屏
            self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)
        }
        
        // 动画
        let animation = CATransition()
        animation.duration = 0.4
        animation.type = kCATransitionReveal
        
        self.layer.addAnimation(animation, forKey: nil)
        
        self.addSubview(tipView)
        
        return self

    }
    
    // MARK: - 公开方法
    // MARK: 实例化方法
    /**
    * Public Method Part
    * 公开函数部分
    */
    ///显示HUD
    func show() {
        // 拿到keywindow
        let window = UIApplication.sharedApplication().keyWindow
        // 加入异步操作之后，如果界面已显示hud，用户再次出发显示hud的操作的时候，可能会导致前一个显示的hud还没有移除而造成重复添加，所以在显示之前判断界面是否已经有hud，如果有，则移除之前的hud并立即显示当前操作触发的hud
        for temp in (window?.subviews)! {
            if let hud: LRTipHUD = temp as? LRTipHUD {
                hud.removeFromSuperview()
            }
        }
        
        window?.addSubview(self.initHud())
        
        // 判断是否自动消失
        if self.hudIsAutoDismiss {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * self.hudAutoDismissTime)), dispatch_get_main_queue()) { () -> Void in
                self.hide()
            }
        } else {
            return
        }
    }
    
    ///移除HUD
    func hide() {
        self.removeFromSuperview()
    }
    
    // MARK: 类方法
    /**
    快速显示hud
    
    - parameter title: 标题
    - parameter tips:  内容
    - parameter time:  自动消失时间（默认自动消失）
    - parameter dim:   是否蒙版背景
    */
    class func showTip(title: String?, tips: String, withTimeInterval time: Double, dimBack dim: Bool) {
        let hud = LRTipHUD()
        hud.hudTitle = title
        hud.hudText = tips
        hud.hudIsAutoDismiss = true
        hud.hudAutoDismissTime = time
        hud.hudIsDimBackground = dim
        hud.show()
    }
    
    /**
     移除所有hud
     */
    class func hideAllHUD() {
        let window = UIApplication.sharedApplication().keyWindow
        for temp in (window?.subviews)! {
            if temp is LRTipHUD {
                temp.removeFromSuperview()
            }
        }
    }
}



