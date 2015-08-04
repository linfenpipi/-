//
//  SYTopicCell.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/30.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYTopicCell.h"
#import "SYTopic.h"
#import <UIImageView+WebCache.h>

@interface SYTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *createTImeLable;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;

@end

@implementation SYTopicCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(SYTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView  sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLable.text = topic.name;
    self.createTImeLable.text = topic.create_time;
    
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
}

- (void)testDate:(NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd  HH:mm:ss";
    NSDate *now = [NSDate date];
    NSDate *create = [fmt dateFromString:create_time];
    
    SYLog(@"%@", [now dateFrom:create]);
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    }else if (count > 0)
    {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    
}
- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
