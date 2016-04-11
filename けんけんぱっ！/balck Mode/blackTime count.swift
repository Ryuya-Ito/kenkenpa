//
//  balckTime count.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2016/01/30.
//  Copyright © 2016年 Ryu. All rights reserved.
//

import UIKit


class blackTimecountviewController : UIViewController {
    
    //変数宣言
    private var myImage: UIImageView!
    private var myImage2: UIImageView!
    private var myImage3: UIImageView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //タイマーをリピートで１秒ごとに繰り返す
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("counting"), userInfo: nil, repeats: true)
        
        //背景色を設定
        self.view.backgroundColor = UIColor.orangeColor()
        
        
    }
    
    func counting(){
        count += 1
        
        if count == 1 {
            
            myImage = UIImageView(frame: CGRectMake(0,0,200,200))
            let countimage = UIImage(named: "countnumber3.png")
            myImage.image = countimage
            myImage.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
            self.view.addSubview(myImage)
            
        }
        if count == 2 {
            
            myImage2 = UIImageView(frame: CGRectMake(0,0,200,200))
            let countimage2 = UIImage(named: "countnumber2.png")
            myImage2.image = countimage2
            myImage2.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
            self.view.addSubview(myImage2)
        }
        if count == 3 {
            
            myImage3 = UIImageView(frame: CGRectMake(0,0,200,200))
            let countimage3 = UIImage(named: "countnumber1.png")
            myImage3.image = countimage3
            myImage3.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
            self.view.addSubview(myImage3)
        }
        if count == 4 {
            
            //タイマーの停止
            timer.invalidate()
            
            //移動するページの定義
            let myviewcontroller: UIViewController = blackTimegameviewController()
            
            //ページの移動
            self.presentViewController(myviewcontroller, animated: true, completion: nil)
            
            count = 0
        }
    }
    
    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
