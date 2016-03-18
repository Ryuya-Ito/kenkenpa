//
//  Game3.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2015/10/25.
//  Copyright (c) 2015年 Ryu. All rights reserved.
//

import UIKit
import iAd

class Game3viewController : UIViewController {
    
    //変数宣言
    
    private var myImage: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //iAdバナーの自動表示
        self.canDisplayBannerAds = true
        //iAdインタースティスシャルの自動表示
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
        
        //背景色を設定
        self.view.backgroundColor = UIColor.orangeColor()
        
}
    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}