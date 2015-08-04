//
//  SYMeViewController.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/22.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYMeViewController.h"

@interface SYMeViewController ()

@end

@implementation SYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
//    self.navigationItem.titleView = [UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"];
    
    
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(MoonClick)];
    
    
    self.navigationItem.rightBarButtonItems = @[settingButton,moonButton];
    /*
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithCustomView:settingButton],
    
                                                [[UIBarButtonItem alloc] initWithCustomView:moonButton]
                                                ];
  */
    
}
- (void)settingClick
{
    SYLogFunc;
}
- (void)MoonClick
{
    SYLogFunc;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
