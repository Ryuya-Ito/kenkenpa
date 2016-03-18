//
//  start.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2015/10/18.
//  Copyright (c) 2015年 Ryu. All rights reserved.
//

import UIKit

@objc(normalviewController)
class normalviewController : UIViewController ,NADViewDelegate, NADInterstitialDelegate {
    
    //変数宣言
    
    private var nadView: NADView!
    
    private var myImage: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //背景色を設定
        self.view.backgroundColor = UIColor.orangeColor()
        
        //ボタン生成
        let score: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.height/13))
        score.backgroundColor = UIColor.blueColor()
        score.layer.masksToBounds = true
        score.setTitle("スコアアタック", forState: .Normal)
        score.layer.cornerRadius = 20.0
        score.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height/2)
        score.addTarget(self, action: "score:",forControlEvents: .TouchUpInside)
        self.view.addSubview(score)
        
        //ボタン生成
        let score1: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.height/13))
        score1.backgroundColor = UIColor.blueColor()
        score1.layer.masksToBounds = true
        score1.setTitle("タイムアタック", forState: .Normal)
        score1.layer.cornerRadius = 20.0
        score1.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/4)
        score1.addTarget(self, action: "score1:",forControlEvents: .TouchUpInside)
        self.view.addSubview(score1)
        
        //ボタン生成
        let button = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width/9.5, self.view.bounds.height/16))
        let buttonImage:UIImage = UIImage(named: "yajirusi.png")!
        button.layer.cornerRadius = 20.0
        button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        button.layer.position = CGPoint(x: self.view.bounds.width/10, y:self.view.bounds.height/11.5)
        button.addTarget(self, action: "back:", forControlEvents:.TouchUpInside)
        self.view.addSubview(button)
        
        // NADViewクラスを生成
        nadView = NADView(frame: CGRect(x: 0, y: 0, width: 320, height: 50), isAdjustAdSize: true)
        
        nadView = NADView(isAdjustAdSize: true)
        // 広告枠のapikey/spotidを設定(必須)
        nadView.setNendID("f79f3e55c1960e4ec5511351c0c12bd8bbaf3aa6",spotID: "550575")
        // nendSDKログ出力の設定(任意)
        nadView.isOutputLog = false
        // delegateを受けるオブジェクトを指定(必須)
        nadView.delegate = self
        // 読み込み開始(必須)
        nadView.load()
        
        self.view.addSubview(nadView)
    
    }
    
    deinit {
        nadView.delegate = nil
        nadView = nil
        
    }
    
    func nadViewDidFinishLoad(adView: NADView!) {
        // 広告のロードが完了してからViewを乗せる場合はnadViewDidFinishLoadを利用します。
        // 画面下部に広告を表示させる場合
        nadView.frame = CGRect(x: (self.view.frame.size.width - nadView.frame.size.width)/2, y: self.view.frame.size.height - nadView.frame.size.height, width: nadView.frame.size.width, height: nadView.frame.size.height)
        self.view.addSubview(nadView)
    }
    
    //ボタンイベント
    internal func score(sender: UIButton){
        
        NADInterstitialShowResult.self
        NADInterstitial.sharedInstance().showAd()
        
        let view: UIViewController = ScoreCountviewController()
        
        self.presentViewController(view,animated: true, completion: nil)
    }
    //ボタンイベント
    internal func score1(sender: UIButton){
        
        NADInterstitialShowResult.self
        NADInterstitial.sharedInstance().showAd()
        
        let view1: UIViewController = TimeCountviewController()
        
        self.presentViewController(view1,animated: true, completion: nil)
    }
    
    //ボタンイベント
    internal func back(sender: UIButton){
        
        NADInterstitialShowResult.self
        NADInterstitial.sharedInstance().showAd()
        
        let backs: UIViewController = FirstViewController()
        
        self.presentViewController(backs,animated:  true,completion:  nil)
    }
    
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        

}

