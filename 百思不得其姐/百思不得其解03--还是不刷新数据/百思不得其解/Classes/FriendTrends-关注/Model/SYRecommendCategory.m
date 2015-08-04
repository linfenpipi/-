//
//  SYRecommendCategory.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/25.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYRecommendCategory.h"

@implementation SYRecommendCategory

- (NSMutableArray *)users
{
    if (!_user) {
        _user = [NSMutableArray array];
    }
    return _user;
}

@end
