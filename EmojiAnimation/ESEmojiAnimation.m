//
//  ViewController.m
//  EmojiAnimation
//
//  Created by HWB on 2018/10/5.
//  Copyright © 2018 HWB. All rights reserved.
//

#import "ESEmojiAnimation.h"
#import <UIKit/UIKit.h>


#define EMOJI_W      30   //表情款
#define EMOJI_H      30   //表情高
#define ANIMATION_STOP_TIME    5.f     //超过这个时间，不再新增下飘表情
#define ANIMATION_REMOVE_TIME  4.f     //延迟关闭定时器，等所有表情飘到屏幕外后关闭。最好根据屏幕判断一下，屏幕短的不需要那么久飘完
#define ANIMATION_CHANGE_TIME  0.2f    //间隔新增下落表情
#define EMOJI_SCREEN_W ([UIScreen mainScreen].bounds.size.width)    //屏幕宽，请替换为自己项目所使用的宏
#define EMOJI_SCREEN_H ([UIScreen mainScreen].bounds.size.height)   //屏幕高，请替换为自己项目所使用的宏


@interface ESEmojiAnimation ()

@property (nonatomic, retain) NSTimer * timer;     //定时器

@property (nonatomic, assign) CGFloat timeCount;   //增量，超过时间关闭

@property (nonatomic, retain) CALayer * sLayer;    //添加的llayer

@property (nonatomic, retain) UIView * bgView;     //添加layer的view

@property (nonatomic, retain) NSString * imageName;//下落的表情的名称

@end

@implementation ESEmojiAnimation

+(ESEmojiAnimation *)startAnimationWithEmojiType:(EmojiAnimationType)type andShowInView:(id)sView
{
    ESEmojiAnimation  * emojiAnimation = [[ESEmojiAnimation alloc] init];
    [emojiAnimation imageNameWithShowType:type];
    emojiAnimation.bgView = sView;
    emojiAnimation.timeCount = 0.f;
    [emojiAnimation createView];
    
    return emojiAnimation;
}

-(void)createView
{
    [_timer invalidate];
    _timer = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:ANIMATION_CHANGE_TIME target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
}

-(void)timerStart
{
    _timeCount += ANIMATION_CHANGE_TIME;
    if (_timeCount > ANIMATION_STOP_TIME) {
        
        if (_timeCount <= ANIMATION_STOP_TIME + ANIMATION_CHANGE_TIME) {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopAnimation) object:nil];
            [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:ANIMATION_REMOVE_TIME];
        }
        return;
    }

    UIImageView * imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, EMOJI_W, EMOJI_H)];
    [imagev setUserInteractionEnabled:YES];
    [imagev setImage:[UIImage imageNamed:_imageName]];
    
    
    _sLayer = [[CALayer alloc] init];
    _sLayer.bounds = imagev.frame;
    _sLayer.anchorPoint = CGPointMake(0,0);
    _sLayer.position = CGPointMake(0,-40);
    _sLayer.contents = (__bridge id)[imagev.image CGImage];
    [_bgView.layer addSublayer:_sLayer];
    [self startAnimation];
}


-(void)startAnimation
{
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGFloat S_XA = arc4random_uniform(EMOJI_SCREEN_W);
    CGFloat S_XB = arc4random_uniform(EMOJI_SCREEN_W);

    NSValue * value = [NSValue valueWithCGPoint:CGPointMake(S_XA, 10)];
    NSValue * value1 = [NSValue valueWithCGPoint:CGPointMake(S_XB, EMOJI_SCREEN_H + 10)];
    moveAnimation.values=@[value,value1];

    moveAnimation.duration = 4;
    moveAnimation.repeatCount = 1;
    moveAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_sLayer addAnimation:moveAnimation forKey:@"move"];
}



-(void)stopAnimation
{
    [_timer invalidate];
    _timer = nil;
    
    for (CALayer * item in _bgView.layer.sublayers){
        [item removeAllAnimations];
    }
}


-(void)viewDelloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopAnimation) object:nil];

    [self stopAnimation];
}


-(void)imageNameWithShowType:(EmojiAnimationType)showType
{
    
    switch (showType) {
        case EmojiAnimationType_NO:
        {}break;
            
        case EmojiAnimationType_MeMeDa:
        {_imageName = @"emoji_24";}break;
            
        case EmojiAnimationType_Chou:
        {_imageName = @"emoji_44";}break;
            
        case EmojiAnimationType_LaJi:
        {_imageName = @"emoji_33";}break;

        case EmojiAnimationType_PiaoLiang:
        {_imageName = @"emoji_58";}break;

        case EmojiAnimationType_HaoHaoKan:
        {_imageName = @"emoji_10";}break;

        case EmojiAnimationType_MaiJiaZhenHao:
        {_imageName = @"emoji_16";}break;

        case EmojiAnimationType_XiaoJieJie:
        {_imageName = @"emoji_59";}break;

        case EmojiAnimationType_XiaoGeGe:
        {_imageName = @"emoji_74";}break;
        
        case EmojiAnimationType_HaHaHa:
        {_imageName = @"emoji_38";}break;
            
        case EmojiAnimationType_LiuLiuLiu:
        {_imageName = @"emoji_57";}break;


        default:
            break;
    }
}

+(NSInteger)needAnimationWithInput:(NSString *)type
{
    if ([type rangeOfString:@"么么哒"].location != NSNotFound) {
        return EmojiAnimationType_MeMeDa;
    }
    
    if ([type rangeOfString:@"丑"].location != NSNotFound) {
        return EmojiAnimationType_Chou;
    }
    
    if ([type rangeOfString:@"垃圾"].location != NSNotFound) {
        return EmojiAnimationType_LaJi;
    }
    
    if ([type rangeOfString:@"漂亮"].location != NSNotFound) {
        return EmojiAnimationType_PiaoLiang;
    }
    
    if ([type rangeOfString:@"好好看"].location != NSNotFound) {
        return EmojiAnimationType_HaoHaoKan;
    }
    
    if ([type rangeOfString:@"卖家真好"].location != NSNotFound) {
        return EmojiAnimationType_MaiJiaZhenHao;
    }
    
    if ([type rangeOfString:@"小姐姐"].location != NSNotFound) {
        return EmojiAnimationType_XiaoJieJie;
    }
    
    if ([type rangeOfString:@"小哥哥"].location != NSNotFound) {
        return EmojiAnimationType_XiaoGeGe;
    }
    
    if ([type rangeOfString:@"哈哈哈"].location != NSNotFound) {
        return EmojiAnimationType_HaHaHa;
    }
    
    if ([type rangeOfString:@"666"].location != NSNotFound || [type rangeOfString:@"233"].location != NSNotFound) {
        return EmojiAnimationType_LiuLiuLiu;
    }
    
    return EmojiAnimationType_NO;
}


@end
