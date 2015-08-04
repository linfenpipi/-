//
//  SYTextFiled.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/26.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYTextFiled.h"
#import <objc/runtime.h>
@implementation SYTextFiled

static NSString * const SYPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

- (void)awakeFromNib
{
//    unsigned int count = 0;
//    Ivar *ivars =  class_copyIvarList([self class], &count);
//    free(ivars);
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];

}

//+ (void)initialize
//{
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i<count; i++) {
//        
//        Ivar ivar = ivars[i];
//        
//        SYLog(@"%s,%s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
//    }
//    
//        free(ivars);
//}

- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:SYPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

// 当前文本框失去焦点时就会调用
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:SYPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}




@end
