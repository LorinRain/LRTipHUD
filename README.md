# LRTipHUD
a simple HUD

 ![image](https://github.com/LorinRain/LRTipHUD/raw/master/ScreenShots/LRTipHud.gif)

Installation
==============
Drag file `LRTipHUD.swift` to your project

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
