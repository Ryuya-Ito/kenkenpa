//
//  Game1.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2015/10/30.
//  Copyright (c) 2015年 Ryu. All rights reserved.
//

import UIKit
import AVFoundation
import Social

var time0 = NSTimer()

var timeover: Float = 20.00


var score: Int = 0

class ScoreGameviewController : UIViewController {
    
    weak var imageview : UIImageView!
    
    var blackimageview : UIImageView!
    
    let timelabel = UILabel(frame: CGRectMake(0,0,120,20));
    let scoreLabel = UILabel(frame: CGRectMake(0,0,120,30));
    
    private var img_view : UIImageView!
    private var myImage0 : UIImageView!
    private var myImage1 : UIImageView!
    
    private var myImageA : UIImage!
    private var myImageB : UIImage!
    
    private var imgArray:[UIImage] = []
    
    var audioplay : AVAudioPlayer!
    
    var player : AVAudioPlayer? //BGM再生
    let sounddata = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ken-ken-pa", ofType: "mp3")!)
    
    var touchsound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("footstep-stone", ofType: "mp3")!)
    
    var touchplay = AVAudioPlayer()
    
    override func viewDidLoad() {
        
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
        
        //画像の名前
        myImageA = UIImage(named: "ken2.png")
        myImageB = UIImage(named: "ken3.png")
        
        
        //背景色を設定
        self.view.backgroundColor = UIColor.orangeColor()
        
        //スコアカウント設定
        scoreLabel.text = "0";
        scoreLabel.font = UIFont.systemFontOfSize(24)
        scoreLabel.layer.position = CGPoint(x: self.view.bounds.width/4, y: self.view.bounds.height/15)
        self.view.addSubview(scoreLabel);
        
        //タイムラベル設定
        timelabel.text = "20.00";
        timelabel.font = UIFont.systemFontOfSize(24) //フォントサイズ
        timelabel.layer.position = CGPoint(x: self.view.bounds.width/1.1, y: self.view.bounds.height/15)
        self.view.addSubview(timelabel);
        
        
        //1秒ごとに減る
        time0 = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("count"), userInfo: nil, repeats: true)
        
        //UIImageViewを作成する
        img_view = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width/4,self.view.bounds.height/15))
        
        //表示する画像を設定する
        let myimage = UIImage(named: "ken2.png")
        
        //画像をUIImageViewに設定する
        img_view.image = myimage
        
        //画像を表示する座標を指定する
        img_view.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/5.3)//ランダムにさせたい場所
        
        //UIImageViewをViewに追加する
        self.view.addSubview(img_view)
        
        //ランダム生成
        imgArray = [myImageA,myImageB]
        
        let ret = Int(arc4random_uniform(2))
        
        img_view.image = imgArray[ret]
        
        
        //UIImageViewを作成する
        myImage0 = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width/2.6,self.view.bounds.height/9))
        
        //表示する画像を設定する
        let myimageview = UIImage(named: "ken3.png")
        
        //画像をUIImageViewに設定する
        myImage0.image = myimageview
        
        //画像を表示する座標を指定する
        myImage0.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2.6)
        
        //UIImageViewをViewに追加する
        self.view.addSubview(myImage0)
        
        //UIImageViewを作成する
        myImage1 = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.height/7))
        
        //表示する画像を設定する
        let myimageview1 = UIImage(named: "ken2.png")
        
        //画像をUIImageViewに設定する
        myImage1.image = myimageview1
        
        //画像を表示する座標を指定する
        myImage1.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/1.6)
        
        //UIImageViewをViewに追加する
        self.view.addSubview(myImage1)
        
        //ボタン生成
        let nextbutton: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2.7,self.view.bounds.height/13))
        nextbutton.backgroundColor = UIColor.blueColor();
        nextbutton.layer.masksToBounds = true
        nextbutton.setTitle("けん！",forState: .Normal)
        nextbutton.layer.cornerRadius = 20.0
        nextbutton.layer.position = CGPoint(x: self.view.bounds.width/1.32, y:self.view.bounds.height/1.145)
        nextbutton.addTarget(self, action: "MyButton:", forControlEvents: .TouchUpInside)
        
        nextbutton.tag = 0
        //ボタンを追加する
        self.view.addSubview(nextbutton)
        
        
        //ボタン生成
        let nextbutton1: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2.7,self.view.bounds.height/13))
        nextbutton1.backgroundColor = UIColor.blueColor();
        nextbutton1.layer.masksToBounds = true
        nextbutton1.setTitle("ぱっ！",forState: .Normal)
        nextbutton1.layer.cornerRadius = 20.0
        nextbutton1.layer.position = CGPoint(x: self.view.bounds.width/4, y:self.view.bounds.height/1.145)
        nextbutton1.addTarget(self, action: "MyButton1:",forControlEvents: .TouchUpInside)
        
        nextbutton1.tag = 1
        
        //ボタンを追加する
        self.view.addSubview(nextbutton1)
        
        touchplay = try! AVAudioPlayer(contentsOfURL: touchsound, fileTypeHint: nil)
        touchplay.prepareToPlay()
        
}
    
    
    //ボタンイベント
       func MyButton(sender: UIButton){
        
        touchplay.currentTime = 0 //押すたびに表示させるため
        touchplay.play()
        
           if myImage1.image == myImageA {
            score+=10
            scoreLabel.text = String(score)
            
            myImage1.image = myImage0.image
            
            myImage0.image = img_view.image
            
            //ランダム生成
            imgArray = [myImageA,myImageB]
            
            let ret = Int(arc4random_uniform(2))
            
            img_view.image = imgArray[ret]
              return
           }
            else {
            
               score-=10
               scoreLabel.text = String(score)
            
            myImage1.image = myImage0.image
            
            myImage0.image = img_view.image
            
            //ランダム生成
            imgArray = [myImageA,myImageB]
            
            let ret = Int(arc4random_uniform(2))
            
            img_view.image = imgArray[ret]
        }
        
    }


        //ボタンイベント
       func MyButton1(sender: UIButton){
        
        touchplay.currentTime = 0
        touchplay.play()
        
        if myImage1.image == myImageB {
                score+=10
                scoreLabel.text = String(score)
            
                myImage1.image = myImage0.image
            
                myImage0.image = img_view.image
            
            //ランダム生成
            imgArray = [myImageA,myImageB]
            
            let ret = Int(arc4random_uniform(2))
            
            img_view.image = imgArray[ret]
            
                return
            }
            else {
                score-=10
                scoreLabel.text = String(score)
            
                myImage1.image = myImage0.image
            
                myImage0.image = img_view.image
            
            //ランダム生成
            imgArray = [myImageA,myImageB]
            
            let ret = Int(arc4random_uniform(2))
            
            img_view.image = imgArray[ret]        }
        
        }
    
    
            
    //0秒になったらの処理
    func count() {

            timeover -= 0.01
            timelabel.text = "\(timeover)"
        
        let str0 = "".stringByAppendingFormat("%.2f", timeover)//小数点２桁まで表示
        timelabel.text = str0
        
        if timelabel.text == "0.01" {
            time0.invalidate()
            
            let view: UIViewController = ScoreGameoverviewController()
            
            player?.stop()
            
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setInteger(score, forKey: "score")
            
            
            
            self.presentViewController(view, animated: true, completion: nil)
            timeover = 20.00
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}