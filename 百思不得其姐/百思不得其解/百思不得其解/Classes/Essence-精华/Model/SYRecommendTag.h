//
//  SYRecommendTag.h
//  百思不得其解
//
//  Created by 孙寅 on 15/7/28.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYRecommendTag : NSObject
/** 图片 */
@property (nonatomic, copy)NSString *image_list;

/** 名字 */
@property (nonatomic, copy)NSString *theme_name;

/** 订阅数 */
@property (nonatomic, assign)NSInteger sub_number;
@end
