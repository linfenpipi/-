//
//  SYRecommendTagCell.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/28.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYRecommendTagCell.h"
#import "SYRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface SYRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLable;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLable;

@end



@implementation SYRecommendTagCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendTag:(SYRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLable.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number/ 10000.0];
    }
    
    self.subNumberLable.text = subNumber;
    
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
