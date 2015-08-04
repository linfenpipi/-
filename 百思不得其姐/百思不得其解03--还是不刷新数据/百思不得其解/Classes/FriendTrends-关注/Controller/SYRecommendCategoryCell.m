//
//  SYRecommendCategoryCell.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/25.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYRecommendCategoryCell.h"
#import "SYRecommendCategory.h"
@interface SYRecommendCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation SYRecommendCategoryCell



- (void)awakeFromNib {
    self.backgroundColor = SYRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = SYRGBColor(218, 21, 26);
}


- (void)setCategory:(SYRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2*self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : SYRGBColor(78, 78, 78);
}

@end
