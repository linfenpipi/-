//
//  SYFriendViewController.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/22.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYFriendViewController.h"
#import "SYRecommendViewController.h"
#import "SYLoginViewController.h"

@interface SYFriendViewController ()

@end

@implementation SYFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title =@"我的关注";
//    self.title = @"我的关注";
//    self.tabBarItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    self.view.backgroundColor = SYGlobalBg;
    
}
- (void)friendsClick
{
    SYRecommendViewController *vc = [[SYRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)loginRegister {
    
    SYLoginViewController *vc = [[SYLoginViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
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
