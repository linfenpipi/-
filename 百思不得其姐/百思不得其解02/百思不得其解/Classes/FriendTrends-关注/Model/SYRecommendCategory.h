//
//  SYRecommendCategory.h
//  百思不得其解
//
//  Created by 孙寅 on 15/7/25.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYRecommendCategory : NSObject

/** ID */
@property (nonatomic, assign)NSUInteger id;

/** 总数 */
@property (nonatomic, assign)NSInteger count;

/** 名字 */
@property (nonatomic, copy)NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong)NSMutableArray *user;
@end
