//
//  SYViewController.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/22.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYEssenceViewController.h"
#import "SYRecommendTagsViewController.h"
#import "SYAllViewController.h"
#import "SYVideoViewController.h"
#import "SYVoiceViewController.h"
#import "SYPictureViewController.h"
#import "SYWordViewController.h"

@interface SYEssenceViewController ()<UIScrollViewDelegate>

/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;

/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/**  */
@property (nonatomic, strong)UIScrollView *contentView;
@property (nonatomic, weak) UIView *titlesView;

@end

@implementation SYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupChildVces];
    
    [self setupTitleView];
 
    [self setupContentView];
}

- (void)setupChildVces
{
    
    SYAllViewController *all = [[SYAllViewController alloc] init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    SYVideoViewController *video = [[SYVideoViewController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    SYVoiceViewController *voice = [[SYVoiceViewController alloc] init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    SYPictureViewController *picture = [[SYPictureViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    SYWordViewController *word = [[SYWordViewController alloc] init];
    word.title = @"段子";
    [self addChildViewController:word];
    
}

- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titleView.width = self.view.width;
    titleView.height = SYTitlesViewH;
    titleView.y = SYTitlesViewY;
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titleView.height - indicatorView.height;

    self.indicatorView = indicatorView;
    
    //内部的子控件
    
    CGFloat width = titleView.width / self.childViewControllers.count;
    CGFloat height = titleView.height;

    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            
            self.selectedButton = button;
            
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titleView addSubview:indicatorView];
}
- (void)titleClick:(UIButton *)button
{
    
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

    self.view.backgroundColor = SYGlobalBg;
}

- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);

    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}


- (void)tagClick
{
    SYRecommendTagsViewController *tags = [[SYRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
    
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
