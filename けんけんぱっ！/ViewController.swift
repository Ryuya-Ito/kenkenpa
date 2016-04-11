//
//  ViewController.swift
//  けんけんぱっ！
//
//  Created by Ryu on 2015/10/18.
//  Copyright (c) 2015年 Ryu. All rights reserved.
//

import UIKit

class ViewController: UIViewController , ADFmyMovieRewardDelegate {
    
    /*var mMovieReward: ADFmyMovieReward?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景色を設定
        self.view.backgroundColor = UIColor.orangeColor()
        
        //ボタン生成
        let nextbutton: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.height/13))
        nextbutton.backgroundColor = UIColor.blueColor();
        nextbutton.layer.masksToBounds = true
        nextbutton.setTitle("視聴する",forState: .Normal)
        nextbutton.layer.cornerRadius = 20.0
        nextbutton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/1.69)
        nextbutton.addTarget(self, action: "MyButton:", forControlEvents: .TouchUpInside)
        
        //ボタンを追加する
        self.view.addSubview(nextbutton);
        
        mMovieReward = ADFmyMovieReward.getInstance("56d405592d34956f65000012", delegate: self)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ボタンイベント
    internal func MyButton(sender: UIButton){
        
        // UIAlertControllerを作成する.
        let alert: UIAlertController = UIAlertController(title: "動画視聴で解放" , message: "動画を視聴しますか？", preferredStyle:  UIAlertControllerStyle.Alert)
        
        let okaction: UIAlertAction = UIAlertAction(title: "YES",style:  UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) -> Void in
            print("OK")
        
            func AdsFetchCompleted(isTestMode_inApp: Bool) {
                
            }
            //動画の準備が完了していたら、再生
            if let movieReward = self.mMovieReward{
            if movieReward.isPrepared() {
            movieReward.play()
            }
                
            let Button: UIViewController = normalviewController()
                
            // UIAlertを発動する.
            self.presentViewController(Button, animated: true, completion: nil)
                
            }
            
        })
        
        
        let canselaction: UIAlertAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.Cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cansel")
            
        })
        
        alert.addAction(okaction)
        alert.addAction(canselaction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }

    /**
    動画広告の読み込みが完了した時に呼ばれるデリゲート
    */
    /*func AdsFetchCompleted(isTestMode_inApp: Bool) {
        //動画の準備が完了していたら、再生
        
        if let movieReward = self.mMovieReward{
            if movieReward.isPrepared() {
                movieReward.play()
            }
        }

    }
    
    /**
     動画の表示を開始した時に呼ばれるデリゲート
     */
    func AdsDidShow(adnetworkKey: String!) {
        
    }
    
    /**
     動画広告の再生が完了した時に呼ばれるデリゲート
     */
    func AdsDidCompleteShow() {
        
    }
    
    /**
     動画広告を閉じた時に呼ばれるデリゲート
     */
    func AdsDidHide() {
        
    }
    
    /**
     動画広告の再生エラー時に呼ばれるデリゲート
     */
    func AdsPlayFailed() {
        
    }*/
}

*/
}
