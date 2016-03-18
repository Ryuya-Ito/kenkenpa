//
//  Title.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2015/10/18.
//  Copyright (c) 2015年 Ryu. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

@objc(FirstViewController)

class FirstViewController: UIViewController,AVAudioPlayerDelegate, NADViewDelegate, NADInterstitialDelegate, ADFMovieRewardDelegate{ //ストーリボードの代わり
    
    private var nadView: NADView!

    var label = UILabel(frame: CGRectMake(130,40,400,400))
    
    var audioplay : AVAudioPlayer!
    
    var player : AVAudioPlayer? //BGM再生
    let sounddata = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ken-ken-pa", ofType: "mp3")!)
    
    private var myImage: UIImageView!
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        do {
            //ローカル変数に格納していたのを修正
            player = try AVAudioPlayer(contentsOfURL: sounddata)
            player?.play()
        }
        catch let error as NSError {
            print(error)
        }
        
        player?.prepareToPlay()
    
        //背景色を設定
        self.view.backgroundColor = UIColor.orangeColor()
        
        //写真追加
        myImage = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width/1,self.view.bounds.height/2.4))
        let countimage = UIImage(named: "mainken.png")
        myImage.image = countimage
        myImage.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/3.5)
        self.view.addSubview(myImage)
    
        //ボタン生成
        let nextbutton: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.height/13))
        nextbutton.backgroundColor = UIColor.blueColor();
        nextbutton.layer.masksToBounds = true
        nextbutton.setTitle("ノーマルモード",forState: .Normal)
        nextbutton.layer.cornerRadius = 20.0
        nextbutton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/1.69)
        nextbutton.addTarget(self, action: "MyButton:", forControlEvents: .TouchUpInside)
        
        //ボタンを追加する
        self.view.addSubview(nextbutton);
        
        //ボタン生成
        let nextbutton4: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.height/13))
        nextbutton4.backgroundColor = UIColor.blueColor();
        nextbutton4.layer.masksToBounds = true
        nextbutton4.setTitle("ミラーモード",forState: .Normal)
        nextbutton4.layer.cornerRadius = 20.0
        nextbutton4.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/1.45)
        nextbutton4.addTarget(self, action: "MyButton4:",forControlEvents: .TouchUpInside)
        self.view.addSubview(nextbutton4);
        
        
        //ボタン生成
        let nextbutton2: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.height/13))
        nextbutton2.backgroundColor = UIColor.blueColor();
        nextbutton2.layer.masksToBounds = true
        nextbutton2.setTitle("暗闇モード",forState: .Normal)
        nextbutton2.layer.cornerRadius = 20.0
        nextbutton2.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/1.28)
        nextbutton2.addTarget(self, action: "MyButton2:",forControlEvents: .TouchUpInside)
        self.view.addSubview(nextbutton2);
        
        //ボタン生成
        let nextbutton3: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.height/13))
        nextbutton3.backgroundColor = UIColor.blueColor();
        nextbutton3.layer.masksToBounds = true
        nextbutton3.setTitle("暗記モード",forState: .Normal)
        nextbutton3.layer.cornerRadius = 20.0
        nextbutton3.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/1.14)
        nextbutton3.addTarget(self, action: "MyButton3:",forControlEvents: .TouchUpInside)
        
        self.view.addSubview(nextbutton3);
        
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
        
        self.title = "InterstitialAd"
        
        NADInterstitial.sharedInstance().delegate = self
        NADInterstitial.sharedInstance().isOutputLog = true
        
        // 向き固定の場合の処理をここに書く
        let orientationArray =
        [
            UIInterfaceOrientation.Portrait.rawValue,
            UIInterfaceOrientation.PortraitUpsideDown.rawValue,
            UIInterfaceOrientation.LandscapeLeft.rawValue,
            UIInterfaceOrientation.LandscapeRight.rawValue
        ]
        NADInterstitial.sharedInstance().supportedOrientations = orientationArray
        
    }
    
    deinit {
        nadView.delegate = nil
        nadView = nil
        NADInterstitial.sharedInstance().delegate = nil
        
    }
    
    func nadViewDidFinishLoad(adView: NADView!) {
        // 広告のロードが完了してからViewを乗せる場合はnadViewDidFinishLoadを利用します。
        // 画面下部に広告を表示させる場合
        nadView.frame = CGRect(x: (self.view.frame.size.width - nadView.frame.size.width)/2, y: self.view.frame.size.height - nadView.frame.size.height, width: nadView.frame.size.width, height: nadView.frame.size.height)
        self.view.addSubview(nadView)
    }
    
    
    //ボタンイベント
    internal func MyButton(sender: UIButton){
        
        NADInterstitialShowResult.self
        NADInterstitial.sharedInstance().showAd()
        
        player?.stop()
        
        let Button: UIViewController =  normalviewController()
        
        self.presentViewController(Button, animated: true, completion: nil)
        
    }
    
        //ボタンイベント
        internal func MyButton2(sender: UIButton){
            
            NADInterstitialShowResult.self
            NADInterstitial.sharedInstance().showAd()
            
            
                
            player?.stop()
                
            
            let Button2: UIViewController = kurayamiviewController()
                    
            // UIAlertを発動する.
            self.presentViewController(Button2, animated: true, completion: nil)
    }
    
    
        //ボタンイベント
        internal func MyButton3(sender: UIButton){
            
            NADInterstitialShowResult.self
            NADInterstitial.sharedInstance().showAd()
            
            player?.stop()
                
            
                    
            let Button3: UIViewController = ankiviewController()
                    
            // UIAlertを発動する.
            self.presentViewController(Button3, animated: true, completion: nil)
            
    }
    
        //ボタンイベント
        internal func MyButton4(sender: UIButton){

            
            NADInterstitialShowResult.self
            NADInterstitial.sharedInstance().showAd()
            
            player?.stop()
            
            let Button4: UIViewController = mirrorviewController()
            
            // UIAlertを発動する.
            presentViewController(Button4, animated: true, completion: nil)
    }
    
    
       override  func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
    
    }
}