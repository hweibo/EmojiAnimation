//
//  ViewController.m
//  EmojiAnimation
//
//  Created by HWB on 2018/10/5.
//  Copyright © 2018 HWB. All rights reserved.
//

#import "ViewController.h"
#import "ESEmojiAnimation.h"

@interface ViewController ()

@property (nonatomic, retain) ESEmojiAnimation * emojiAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 50, 50)];
    [btn setCenter:self.view.center];
    [btn addTarget:self action:@selector(startEmojiAnimation) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
}

-(void)startEmojiAnimation
{
    //需要Assets 里的 emoji，或者使用自己项目的 emoji
    
    
    //先判断是否需要表情
    EmojiAnimationType needAnimation = [ESEmojiAnimation needAnimationWithInput:@"么么哒"];
    if (needAnimation > 0) {
        
        //日常防止手贱党
        if (_emojiAnimation)  [_emojiAnimation viewDelloc];
        
        //开始表情
       _emojiAnimation = [ESEmojiAnimation startAnimationWithEmojiType:needAnimation andShowInView:self.view];
    }
}


@end
