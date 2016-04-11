//
//  Miss Game.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2016/01/15.
//  Copyright © 2016年 Ryu. All rights reserved.
//

import UIKit
import Social

class MissGameoverviewController : UIViewController ,NADViewDelegate, NADInterstitialDelegate {
    
    //変数宣言
    
    private var nadView: NADView!
    
    private var myImage: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //背景色を設定
        self.view.backgroundColor = UIColor.orangeColor()
        
        // Boldの文字列をラベルに表示する.
        let myBoldLabel: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width/1,self.view.bounds.height/5))
        myBoldLabel.font = UIFont.boldSystemFontOfSize(CGFloat(48))
        myBoldLabel.text = "Game Over!"
        myBoldLabel.layer.position = CGPoint(x: self.view.bounds.width/1.69, y:self.view.bounds.height/3.2)
        self.view.addSubview(myBoldLabel)
        
        //スコアラベル
        let scorelabel: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width/1,self.view.bounds.height/5))
        scorelabel.font = UIFont.systemFontOfSize(32)
        scorelabel.text = "Miss";
        scorelabel.layer.position = CGPoint(x: self.view.bounds.width/1.12, y:self.view.bounds.height/1.8)
        self.view.addSubview(scorelabel)


        //ボタン生成
        let nextbutton: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2.7,self.view.bounds.height/13))
        nextbutton.backgroundColor = UIColor.blueColor();
        nextbutton.layer.masksToBounds = true
        nextbutton.setTitle("リトライ",forState: .Normal)
        nextbutton.layer.cornerRadius = 20.0
        nextbutton.layer.position = CGPoint(x: self.view.bounds.width/1.32, y:self.view.bounds.height/1.145)
        nextbutton.addTarget(self, action: "MyButton:", forControlEvents: .TouchUpInside)
        
        //ボタンを追加する
        self.view.addSubview(nextbutton)
        
        //ボタン生成
        let nextbutton1: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2.7,self.view.bounds.height/13))
        nextbutton1.backgroundColor = UIColor.blueColor();
        nextbutton1.layer.masksToBounds = true
        nextbutton1.setTitle("HOME",forState: .Normal)
        nextbutton1.layer.cornerRadius = 20.0
        nextbutton1.layer.position = CGPoint(x: self.view.bounds.width/4, y:self.view.bounds.height/1.145)
        nextbutton1.addTarget(self, action: "MyButton1:",forControlEvents: .TouchUpInside)
        
        //ボタンを追加する
        self.view.addSubview(nextbutton1)
    
        
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
    internal func MyButton(sender: UIButton){
        
        timeover1 = 0.00
        
        score1 = 20
        
        
        let Button: UIViewController = TimeCountviewController()
        
        self.presentViewController(Button, animated: true, completion: nil)
        
    }
    
    
    
    //ボタンイベント
    internal func MyButton1(sender: UIButton){
        
        NADInterstitialShowResult.self
        NADInterstitial.sharedInstance().showAd()
        
        timeover1 = 0.00
        
        score1 = 20

        
        let Button1: UIViewController = FirstViewController()
        
        self.presentViewController(Button1, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}