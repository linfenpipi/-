//
//  SYRecommendUser.h
//  百思不得其解
//
//  Created by 孙寅 on 15/7/25.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYRecommendUser : NSObject
/** 头像 */
@property (nonatomic, copy)NSString *header;

/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;

/** 昵称 */
@property (nonatomic, copy)NSString *screen_name;
@end
