//
//  MovieReword6004.m
//  SampleViewRecipe
//
//
//  Copyright (c) A .D F. U. L. L. Y Co., Ltd. All rights reserved.
//
//
#import "MovieReward6004.h"

@interface MovieReward6004()<MaioDelegate>
@property (nonatomic, strong) NSString *maioMediaId;

@end


@implementation MovieReward6004

-(id)init
{
    self = [super init];
    
    if ( self ) {
    }
    
    return self;
}


/**
 *  データの設定
 *
 *  @param data
 */
-(void)setData:(NSDictionary *)data
{
    NSLog(@"MovieReward6004 setData : %@", data);
    BOOL testFlg = [[data objectForKey:@"test_flg"] boolValue];
//    [Maio setAdTestMode:YES];
    if(!testFlg){
    }
    else{
        [Maio setAdTestMode:testFlg];
    }

    self.maioMediaId = [NSString stringWithFormat:@"%@", [data objectForKey:@"media_id"]];
}


-(BOOL)isPrepared{
    return [Maio canShow];

}

/**
 *  広告の読み込みを開始する
 */
-(void)startAd
{
    // 動画の読み込みを開始します。
    [Maio startWithMediaId:self.maioMediaId  delegate:self];
    
}



/**
 *  広告の表示を行う
 */
-(void)showAd
{
    if ([Maio canShow]) {
        [Maio show];
    }
}




/**
 * 対象のクラスがあるかどうか？
 *
 *  @return
 */
-(BOOL)isClassReference
{
    Class clazz = NSClassFromString(@"Maio");
    if (clazz) {
    } else {
        NSLog(@"Not found Class: Maio");
        return NO;
    }
    return YES;
}

/**
 *  広告の読み込みを中止
 *
 */
-(void)cancel
{
    // Maio には対象の処理がないので、何もしない。
}

#pragma mark - MaioDelegate


/**
 *  全てのゾーンの広告表示準備が完了したら呼ばれます。
 */
- (void)maioDidInitialize {
    
    // 広告準備完了
    if ( self.delegate ) {
        if ([self.delegate respondsToSelector:@selector(AdsFetchCompleted:)]) {
            [self.delegate AdsFetchCompleted:self];
        }
    }

}

/**
 *  広告の配信可能状態が変更されたら呼ばれます。
 *
 *  @param zoneId   広告の配信可能状態が変更されたゾーンの識別子
 *  @param newValue 変更後のゾーンの状態。YES なら配信可能
 */
- (void)maioDidChangeCanShow:(NSString *)zoneId newValue:(BOOL)newValue {
    // ログ表示
    NSLog(@"%s", __func__);
}

/**
 *  広告が再生される直前に呼ばれます。
 *  最初の再生開始の直前にのみ呼ばれ、リプレイ再生の直前には呼ばれません。
 *
 *  @param zoneId  広告が表示されるゾーンの識別子
 */
- (void)maioWillStartAd:(NSString *)zoneId {
    NSLog(@"%s", __func__);
    
    // WillShow はないので、DidShow で
    if ( self.delegate ) {
        if ([self.delegate respondsToSelector:@selector(AdsDidShow:)]) {
            [self.delegate AdsDidShow:self];
        }
    }
}

/**
 *  広告の再生が終了したら呼ばれます。
 *  最初の再生終了時にのみ呼ばれ、リプレイ再生の終了時には呼ばれません。
 *
 *  @param zoneId  広告を表示したゾーンの識別子
 *  @param playtime 動画の再生時間（秒）
 *  @param skipped  動画がスキップされていたら YES、それ以外なら NO
 *  @param rewardParam  ゾーンがリワード型に設定されている場合、予め管理画面にて設定してある任意の文字列パラメータが渡されます。それ以外の場合は nil
 */
- (void)maioDidFinishAd:(NSString *)zoneId playtime:(NSInteger)playtime skipped:(BOOL)skipped rewardParam:(NSString *)rewardParam {
    NSLog(@"%s", __func__);
    if ( !skipped ) {
        if ( self.delegate ) {
            if ([self.delegate respondsToSelector:@selector(AdsDidCompleteShow:)]) {
                [self.delegate AdsDidCompleteShow:self];
            }
        }
    } else {
        if ( self.delegate ) {
            if ([self.delegate respondsToSelector:@selector(AdsPlayFailed:)]) {
                [self.delegate AdsPlayFailed:self];
            }
        }
    }
}

/**
 *  広告がクリックされ、ストアや外部リンクへ遷移した時に呼ばれます。
 *
 *  @param zoneId  広告を表示したゾーンの識別子
 */
- (void)maioDidClickAd:(NSString *)zoneId {
    NSLog(@"%s", __func__);
}

/**
 *  広告が閉じられた際に呼ばれます。
 *
 *  @param zoneId  広告を表示したゾーンの識別子
 */
- (void)maioDidCloseAd:(NSString *)zoneId {

    NSLog(@"%s", __func__);

    if ( self.delegate ) {
        if ([self.delegate respondsToSelector:@selector(AdsDidHide:)]) {
            [self.delegate AdsDidHide:self];
        }
    }
}

/**
 *  SDK でエラーが生じた際に呼ばれます。
 *
 *  @param zoneId  エラーに関連するゾーンの識別子
 *  @param reason   エラーの理由を示す列挙値
 */
- (void)maioDidFail:(NSString *)zoneId reason:(MaioFailReason)reason {
    // ログ表示
    NSLog(@"%s", __func__);
    NSString *faileMessage = @"";
    
    switch (reason) {
        case MaioFailReasonUnknown:
            faileMessage =  @"Unknown";
            break;
        case MaioFailReasonNetworkConnection:
            faileMessage =  @"NetworkConnection";
            break;
        case MaioFailReasonNetworkServer:
            faileMessage =  @"NetworkServer";
            break;
        case MaioFailReasonNetworkClient:
            faileMessage =  @"NetworkClient";
            break;
        case MaioFailReasonSdk:
            faileMessage =  @"Sdk";
            break;
        case MaioFailReasonDownloadCancelled:
            faileMessage =  @"DownloadCancelled";
            break;
        case MaioFailReasonAdStockOut:
            faileMessage =  @"AdStockOut";
            break;
        case MaioFailReasonVideoPlayback:
            faileMessage =  @"VideoPlayback";
            break;
    }
    
    NSLog(@"Maio SDK Error:%@", faileMessage);
    
    if ( self.delegate ) {
        if ([self.delegate respondsToSelector:@selector(AdsFetchError:)]) {
            [self.delegate AdsFetchError:self];
        }
    }


}

-(void)dealloc{
    if(_maioMediaId != nil){
        _maioMediaId = nil;
    }
}
@end
