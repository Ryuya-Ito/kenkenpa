//
//  ankiTimeGR.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2016/02/01.
//  Copyright © 2016年 Ryu. All rights reserved.
//

import UIKit
import Social


class ankiTimegameoverviewController : UIViewController ,NADViewDelegate, NADInterstitialDelegate {
    
    //変数宣言
    private var nadView: NADView!
    
    var myComposeView : SLComposeViewController!
    var myTwitterButton: UIButton!
    
    private var myImage: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //背景色を設定
        self.view.backgroundColor = UIColor.orangeColor()
        
        
        //スコアとハイスコアをユーザデフォルトから取っておく
        let ud = NSUserDefaults.standardUserDefaults()
        let ankiscore1 = ud.floatForKey("ankiscore1")
        let str  = String(format: "%.2f",ankiscore1)
        var ankihi_score1 = ud.floatForKey("ankihi_score1")
        let str0 = String(format: "%.2f",ankihi_score1)
        
        
        //スコアがハイスコアを上回ったら、ハイスコアを更新！
        if ankihi_score1 == 0.00 {
            
            ud.setFloat(ankiscore1, forKey: "ankihi_score1")
            
            ankihi_score1 = ankiscore1
        }
        
        if ankiscore1 < ankihi_score1 {
            
            ud.setFloat(ankiscore1, forKey: "ankihi_score1")
            ankihi_score1 = ankiscore1
        }
        
        
        // Boldの文字列をラベルに表示する.
        let myBoldLabel: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width/1,self.view.bounds.height/5))
        myBoldLabel.font = UIFont.boldSystemFontOfSize(CGFloat(48))
        myBoldLabel.text = "Game Over!"
        myBoldLabel.layer.position = CGPoint(x: self.view.bounds.width/1.68, y:self.view.bounds.height/3.2)
        self.view.addSubview(myBoldLabel)
        
        //スコアラベル
        let scorelabel: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width/1,self.view.bounds.height/11))
        scorelabel.font = UIFont.systemFontOfSize(24)
        scorelabel.text = "Score:";
        scorelabel.layer.position = CGPoint(x: self.view.bounds.width/1.5, y:self.view.bounds.height/1.9)
        self.view.addSubview(scorelabel)
        
        //ハイスコアラベル
        let hilabel: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width/1,self.view.bounds.height/11))
        hilabel.font = UIFont.systemFontOfSize(24)
        hilabel.text = "Best Score:";
        hilabel.layer.position = CGPoint(x: self.view.bounds.width/1.5, y:self.view.bounds.height/1.7)
        self.view.addSubview(hilabel)
        
        //スコア表示
        let label: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width/1,self.view.bounds.height/11))
        label.font = UIFont.systemFontOfSize(24)
        label.text = "\(ankiscore1)";
        label.text = str
        label.layer.position = CGPoint(x: self.view.bounds.width/1.13, y:self.view.bounds.height/1.9)
        self.view.addSubview(label)
        
        //ハイスコア表示
        let hiscorelabel: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width/1,self.view.bounds.height/11))
        hiscorelabel.font = UIFont.systemFontOfSize(24)
        hiscorelabel.text = "\(ankihi_score1)";
        hiscorelabel.text = str0
        hiscorelabel.layer.position = CGPoint(x: self.view.bounds.width/0.961, y:self.view.bounds.height/1.7)
        self.view.addSubview(hiscorelabel)
        
        
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
        nextbutton1.setTitle("ホーム",forState: .Normal)
        nextbutton1.layer.cornerRadius = 20.0
        nextbutton1.layer.position = CGPoint(x: self.view.bounds.width/4, y:self.view.bounds.height/1.145)
        nextbutton1.addTarget(self, action: "MyButton1:",forControlEvents: .TouchUpInside)
        
        //ボタンを追加する
        self.view.addSubview(nextbutton1)
        
        
        //ボタン生成
        myTwitterButton = UIButton(frame: CGRectMake(0, 0,self.view.bounds.width/3.8,self.view.bounds.height/7))
        let buttonImage:UIImage = UIImage(named: "twitter.png")!
        myTwitterButton.layer.cornerRadius = 20.0
        myTwitterButton.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        myTwitterButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/1.35)
        myTwitterButton.addTarget(self, action: "onPostToTwitter:", forControlEvents:.TouchUpInside)
        self.view.addSubview(myTwitterButton)
        
        // buttonをviewに追加.
        self.view.addSubview(myTwitterButton)
        
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
        
        ankitimeover1 = 0
        
        ankiscore1 = 20
        
        let Button: UIViewController = ankiTimecountviewController()
        
        self.presentViewController(Button, animated: true, completion: nil)
        
    }
    
    
    
    //ボタンイベント
    internal func MyButton1(sender: UIButton){
        
        NADInterstitialShowResult.self
        NADInterstitial.sharedInstance().showAd()
        
        ankitimeover1 = 0
        
        ankiscore1 = 20
        
        let Button1: UIViewController = FirstViewController()
        
        self.presentViewController(Button1, animated: true, completion: nil)
    }
    
    // ボタンイベント.
    func onPostToTwitter(sender : AnyObject) {
        
        // スクリーンショットの取得開始
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 1.0)
        
        // 描画
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        
        // スクリーンショットの取得
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        // スクリーンショットの取得終了
        UIGraphicsEndImageContext()
        
        let ud = NSUserDefaults.standardUserDefaults()
        _ = ud.integerForKey("ankiscore1")
        
        // SLComposeViewControllerのインスタンス化.
        // ServiceTypeをTwitterに指定.
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // 投稿するテキストを指定.
        let theText = String(format: "けんけんぱっ！　タイムは %.2fでした！みんなもやってみよう！　　ダウンロードはこちらhttps://itunes.apple.com/us/app/kenkenpa-tsu!/id1082624420?mt=8　         #けんけんぱっ！", ankitimeover1)
        myComposeView.setInitialText(theText)
        
        // 投稿する画像を指定.
        myComposeView.addImage (screenshot);
        
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
