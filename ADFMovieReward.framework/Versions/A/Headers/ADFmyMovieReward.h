//
//  ADFmyMovieReward.h
//  ADFMovieReword
//
//  (2.0.4)
//  Created by tsukui on 2016/01/20.
//  Copyright (c) 2016年 Adfully All rights reserved.
//  (ご利用になられる前に、必ずマニュアルにて実装方法をご参照ください。
// マニュアルに記述されているもののみ利用可能です)

#import <Foundation/Foundation.h>
#import <UIKit/Uikit.h>
#import "ADFmyMovieRewardInterface.h"

@protocol ADFmyMovieRewardDelegate;

@interface ADFmyMovieReward : NSObject<ADFMovieRewardDelegate>
@property (nonatomic, assign) UIViewController *displayViewController;
@property (nonatomic, weak) NSObject<ADFmyMovieRewardDelegate> *delegate;

-(BOOL)isPrepared;
-(void)play;
-(void)dispose;

+ (BOOL)isSupportedOSVersion;
+ (void)initWithAppID:(NSString *)appID viewController:(UIViewController*)viewController;
+ (ADFmyMovieReward * __nullable)getInstance:(NSString *)appID delegate:(id<ADFmyMovieRewardDelegate>)delegate;
+ (void)disposeAll;
@end

@protocol ADFmyMovieRewardDelegate
@optional

/**< 広告の表示準備が終わった時のイベント */
- (void)AdsFetchCompleted:(BOOL)isTestMode_inApp;
/**< 広告の表示が開始した時のイベント */
- (void)AdsDidShow:(NSString *)adnetworkKey;
/**< 広告の表示が最後まで終わった時のイベント */
- (void)AdsDidCompleteShow;
/**< 動画広告再生エラー時のイベント */
- (void)AdsPlayFailed;
/**< 広告を閉じた時のイベント */
- (void)AdsDidHide;
@end