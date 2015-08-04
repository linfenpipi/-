//
//  SYNavigationController.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/22.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYNavigationController.h"

@implementation SYNavigationController
+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed: @"navigationbarBackgroundWhite"]forBarMetrics:UIBarMetricsDefault];
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
//    
//}

// 拦截所有push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
    if(self.childViewControllers.count > 0 ){
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturn" ] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];

    button.size = CGSizeMake(70, 30);
    // 设置按钮内部左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)back
{
    [self popViewControllerAnimated:YES]; // 返回一个。。
    [self popToRootViewControllerAnimated:YES];// 返回到最顶层

}
@end
