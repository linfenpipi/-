//
//  SYTopic.h
//  百思不得其解
//
//  Created by 孙寅 on 15/7/29.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYTopic : NSObject
/** 名称 */
@property (nonatomic, copy)NSString *name;

/** 头像 */
@property (nonatomic, copy)NSString *profile_image;

/** 发帖时间 */
@property (nonatomic, copy)NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

@property (nonatomic,assign, getter=isSina_v)BOOL sina_v;

@end
