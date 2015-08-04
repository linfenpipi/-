//
//  SYPushGuideView.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/27.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYPushGuideView.h"

@implementation SYPushGuideView

+(void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        SYPushGuideView *guideView = [SYPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
    
        // 存储进去
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        // 马上存入
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)closed {
    
    [self removeFromSuperview];
    
}

@end
