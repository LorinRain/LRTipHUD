//
//  ViewController.swift
//  LRTipHUD
//
//  Created by Lorin on 15/12/11.
//  Copyright © 2015年 LorinRain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func buttonAction1(sender: UIButton) {
        LRTipHUD.showTip("提示", tips: "这是一条提示", withTimeInterval: 0.8, dimBack: true)
    }
    
    @IBAction func buttonAction2(sender: UIButton) {
        let hud = LRTipHUD()
        // 标题
        hud.hudTitle = "提示"
        // 内容
        hud.hudText = "这也是一条提示"
        // 蒙版背景
        hud.hudIsDimBackground = true
        // 自动消失
        hud.hudIsAutoDismiss = true
        // 自动消失时间
        hud.hudAutoDismissTime = 0.8
        // 显示
        hud.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

