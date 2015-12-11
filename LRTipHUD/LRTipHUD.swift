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
    // hud颜色
    // Default is false
    // 默认为白色
    ///hud颜色
    var hudBackgroundColor: UIColor = UIColor.whiteColor()
    
    // 蒙版背景
    // Default is false
    // 默认为否
    ///是否蒙版背景
    var hudIsDimBackground: Bool = false
    
    // 显示标题
    // Default is nil
    // 默认为空
    ///标题
    var hudTitle: String? = nil
    
    // 显示提示内容
    // can not be nil
    // 不能为空
    ///提示内容
    var hudText: String = ""
    
    // 是否圆角
    // Default is true
    // 默认为圆角
    ///是否圆角
    var hudIsFillet: Bool = true
    
    // 圆角角度
    // Only work when hudIsFillet is true, default is 5
    // 仅当hudIsFillet为真的时候设置有效，默认为5
    ///圆角角度
    var hudCornerRadius: CGFloat = 5
    
    // 标题颜色
    // Default is black
    // 默认是黑色
    ///标题颜色
    var hudTitleColor: UIColor = UIColor.blackColor()
    
    // 内容颜色
    // Default is black
    // 默认为黑色
    ///内容颜色
    var hudTextColor: UIColor = UIColor.blackColor()
    
    // 自动消失
    // Default is false
    // 默认为否
    ///是否自动消失
    var hudIsAutoDismiss: Bool = false
    
    // 自动消失时限
    // Only work when hudIsAutoDismiss is true, default is 1.5
    // 仅当hudIsAutoDismiss设置为true的时候有效，默认1.5秒
    ///自动消失时限
    var hudAutoDismissTime: Double = 1.5
    
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
        tipView.center = CGPointMake(SCREENWIDTH*0.5, SCREENHEIGHT*0.5)
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
        if self.hudIsDimBackground {
            self.backgroundColor = UIColor(white: 0, alpha: 0.3)
        } else {
            self.backgroundColor = UIColor.clearColor()
        }
        
        // 设置自身尺寸
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)
        
        // 动画
        let animation1 = CATransition()
        animation1.duration = 0.5
        animation1.type = kCATransitionReveal
        
        self.layer.addAnimation(animation1, forKey: nil)
        
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
    ///快速显示hud
    class func showTip(title: String?, tips: String, withTimeInterval time: Double, dimBack dim: Bool) {
        let hud = LRTipHUD()
        hud.hudTitle = title
        hud.hudText = tips
        hud.hudIsAutoDismiss = true
        hud.hudAutoDismissTime = time
        hud.hudIsDimBackground = true
        hud.show()
    }
    
    ///移除所有hud
    class func hideAllHUD() {
        let window = UIApplication.sharedApplication().keyWindow
        for temp in (window?.subviews)! {
            if temp.isKindOfClass(LRTipHUD) {
                temp.removeFromSuperview()
            }
        }
    }
}



