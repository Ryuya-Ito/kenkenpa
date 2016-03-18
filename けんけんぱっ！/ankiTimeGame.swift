//
//  ankiTimeGame.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2016/02/01.
//  Copyright © 2016年 Ryu. All rights reserved.
//

import UIKit

import AVFoundation

import Social

var ankitimeover1: Float = 0.00

var ankiscore1: Int = 20

var ankitimers = NSTimer()

class ankiTimegameviewController : UIViewController , ADFMovieRewardDelegate{
    
    var timelabel = UILabel(frame: CGRectMake(0,0,120,20));
    var scoreLabel = UILabel(frame: CGRectMake(0,0,120,30));
    
    private var mMovieReward: ADFmyMovieReward?
    
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
        scoreLabel.text = "20";
        scoreLabel.font = UIFont.systemFontOfSize(24)
        scoreLabel.layer.position = CGPoint(x: self.view.bounds.width/4, y: self.view.bounds.height/15)
        self.view.addSubview(scoreLabel);
        
        //タイムラベル設定
        timelabel.text = "0.00";
        timelabel.font = UIFont.systemFontOfSize(24) //フォントサイズ
        timelabel.layer.position = CGPoint(x: self.view.bounds.width/1.1, y: self.view.bounds.height/15)
        self.view.addSubview(timelabel);
        
        //0.01秒づつ呼び出す
        ankitimers = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("count0"), userInfo: nil, repeats: true)
        
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
        myImage1 = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width/2.3,self.view.bounds.height/7))
        
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
        
        
        //ボタンを追加する
        self.view.addSubview(nextbutton1)
        
        touchplay = try! AVAudioPlayer(contentsOfURL: touchsound, fileTypeHint: nil)
        touchplay.prepareToPlay()
        
        //動画リワード
        mMovieReward = ADFmyMovieReward.getInstance("56d405592d34956f65000012", delegate : nil)
        
    }
    
    //ボタンイベント
    func MyButton(sender: UIButton){
        
        touchplay.currentTime = 0 //押すたびに表示させるため
        touchplay.play()
        
        if myImage1.image == myImageA {
            
            ankiscore1-=1
            scoreLabel.text = String(ankiscore1)
            
            myImage1.image = myImage0.image
            
            myImage0.image = img_view.image
            
            //ランダム生成
            imgArray = [myImageA,myImageB]
            
            let ret = Int(arc4random_uniform(2))
            
            img_view.image = imgArray[ret]
            return
        }
        else {
            
            ankitimers.invalidate()
            
            player?.stop()
            
            //動画の準備が完了していたら、再生
            if let movieReward = mMovieReward{
                if movieReward.isPrepared() {
                    movieReward.play()
                }
            }
            
            
            let view: UIViewController = ankiMissGameoverviewController()
            
            self.presentViewController(view, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    //ボタンイベント
    func MyButton1(sender: UIButton){
        
        touchplay.currentTime = 0
        touchplay.play()
        
        if myImage1.image == myImageB {
            ankiscore1-=1
            scoreLabel.text = String(ankiscore1)
            
            myImage1.image = myImage0.image
            
            myImage0.image = img_view.image
            
            //ランダム生成
            imgArray = [myImageA,myImageB]
            
            let ret = Int(arc4random_uniform(2))
            
            img_view.image = imgArray[ret]
            
            return
        }
        else {
            
            ankitimers.invalidate()//タイマー停止
            
            player?.stop()
            
            //動画の準備が完了していたら、再生
            if let movieReward = mMovieReward{
                if movieReward.isPrepared() {
                    movieReward.play()
                }
            }
            
            
            let view: UIViewController = ankiMissGameoverviewController()
            
            self.presentViewController(view, animated: true, completion: nil)
        }
        
    }
    
    
    
    //0秒になったらの処理
    func count0() {
        
        ankitimeover1 += 0.01
        timelabel.text = "\(ankitimeover1)"
        
        let str = String(format: "%.2f", ankitimeover1)//小数点２桁まで表示
        timelabel.text = str
        
        if scoreLabel.text == "15" {
            
            let myImage = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width/1,self.view.bounds.height/4.3))
            let countimage = UIImage(named: "ankiimage.png")
            myImage.image = countimage
            myImage.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/1.57)
            self.view.addSubview(myImage)
            
        }
        
        if scoreLabel.text == "0" {
            
            ankitimers.invalidate()
            
            player?.stop()
            
            
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setFloat(ankitimeover1, forKey: "ankiscore1")
            
            let view: UIViewController = ankiTimegameoverviewController()
            
            self.presentViewController(view, animated: true, completion: nil)
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
