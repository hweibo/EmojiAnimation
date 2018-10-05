//
//  ViewController.m
//  EmojiAnimation
//
//  Created by HWB on 2018/10/5.
//  Copyright © 2018 HWB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,EmojiAnimationType) {
    EmojiAnimationType_NO               =  0,  //不需要表情
    EmojiAnimationType_MeMeDa           =  1,  //么么哒
    EmojiAnimationType_Chou             =  2,  //丑
    EmojiAnimationType_LaJi             =  3,  //垃圾
    EmojiAnimationType_PiaoLiang        =  4,  //漂亮
    EmojiAnimationType_HaoHaoKan        =  5,  //好好看
    EmojiAnimationType_MaiJiaZhenHao    =  6,  //卖家真好/买家真好
    EmojiAnimationType_XiaoJieJie       =  7,  //小姐姐
    EmojiAnimationType_XiaoGeGe         =  8,  //小哥哥
    EmojiAnimationType_HaHaHa           =  9,  //哈哈哈
    EmojiAnimationType_LiuLiuLiu        =  10, //666
};

@interface ESEmojiAnimation : NSObject

+(NSInteger)needAnimationWithInput:(NSString *)type;

+(ESEmojiAnimation *)startAnimationWithEmojiType:(EmojiAnimationType)type andShowInView:(id)sView;

-(void)viewDelloc;

@end

NS_ASSUME_NONNULL_END
