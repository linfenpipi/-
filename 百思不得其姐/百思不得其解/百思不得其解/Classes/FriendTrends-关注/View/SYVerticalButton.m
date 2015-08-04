//
//  SYVerticalButton.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/26.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYVerticalButton.h"

@implementation SYVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    设置图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
//
    
}

@end
