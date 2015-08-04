//
//  UIBarButtonItem+SYExtension.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/22.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "UIBarButtonItem+SYExtension.h"

@implementation UIBarButtonItem (SYExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}
@end
