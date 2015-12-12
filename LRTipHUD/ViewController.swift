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
        LRTipHUD.showTip("提示", tips: "这是一条提示，这条提示显示的时候可以进行其他操作", withTimeInterval: 2, dimBack: false)
    }
    
    @IBAction func buttonAction2(sender: UIButton) {
        let hud = LRTipHUD()
        // 标题
        hud.hudTitle = "提示"
        // 内容
        hud.hudText = "这也是一条提示，这条提示显示的时候不能进行其他操作"
        // 设置非异步
        hud.hudIsAsync = false
        // 自动消失
        hud.hudIsAutoDismiss = true
        // 自动消失时间
        hud.hudAutoDismissTime = 2
        //
        // 显示
        hud.show()
    }
    
    // hud显示范围外面的按钮点击事件（用以测试Hud显示的时候能否进行其他操作）
    @IBAction func asyncBtnAction(sender: UIButton) {
        print("Async button clicked")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

