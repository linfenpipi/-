//
//  SYRecomminUserCell.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/25.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYRecomminUserCell.h"
#import "SYRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface SYRecomminUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLable;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLable;

@end

@implementation SYRecomminUserCell

- (void)setUser:(SYRecommendUser *)user
{
    _user = user;
    self.screenNameLable.text = user.screen_name;
    //@"%zd人关注"
    self.fansCountLable.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];

    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}


@end
