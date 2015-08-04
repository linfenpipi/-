//
//  SYTabBarController.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/22.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYTabBarController.h"
#import "SYEssenceViewController.h"
#import "SYNewViewController.h"
#import "SYFriendViewController.h"
#import "SYMeViewController.h"
#import "SYTabBar.h"
#import "SYNavigationController.h"

@interface SYTabBarController ()

@end

@implementation SYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];


    [UINavigationBar appearance];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selecterattrs = [NSMutableDictionary dictionary];
    selecterattrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selecterattrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selecterattrs forState:UIControlStateSelected];


    [self setupChildVc:[[SYEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectesImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[SYNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectesImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[SYFriendViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectesImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[SYMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectesImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[SYTabBar alloc] init] forKeyPath:@"tabBar"];
    
    
}

// 初始化子控制器
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)titile image:(NSString *)image selectesImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = titile;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = [UIColor colorWithRed:(100) / 100.0  green:(100)/ 100.0 blue:(100) / 100.0 alpha:1.0];
//
    SYNavigationController *nav = [[SYNavigationController alloc] initWithRootViewController:vc];
    
    
    
    [self addChildViewController:nav];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
