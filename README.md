# LRTipHUD
一个用Swift写的提示框

 ![image](https://github.com/LorinRain/LRTipHUD/raw/master/ScreenShots/LRTipHud.gif)

Usage
==============

### Use Class Method
    LRTipHUD.showTip("Tip", tips: "this is a tip", withTimeInterval: 0.8, dimBack: true)

### Use Instance Method
    let hud = LRTipHUD()
    // Title
    hud.hudTitle = "Tip"
    // Content
    hud.hudText = "this is another tip"
    // Dimbackground
    hud.hudIsDimBackground = true
    // AutoDismiss
    hud.hudIsAutoDismiss = true
    // AuotoDismiss time
    hud.hudAutoDismissTime = 0.8
    // show
    hud.show()