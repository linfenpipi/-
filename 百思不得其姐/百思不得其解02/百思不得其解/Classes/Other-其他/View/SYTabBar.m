//
//  SYTabBar.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/22.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYTabBar.h"
@interface SYTabBar()
/** 发布按钮 */
@property (nonatomic, weak)UIButton *publishButton;
@end
@implementation SYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *plistButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plistButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plistButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon" ] forState:UIControlStateHighlighted];
        [self addSubview:plistButton];
        self.publishButton  = plistButton;
    }
    return self;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
    
    for (UIView *button  in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) {
        
            continue;
        }
        
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame =CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
}
    
    
    
}

@end
