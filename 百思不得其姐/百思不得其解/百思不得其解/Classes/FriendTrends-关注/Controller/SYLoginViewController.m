//
//  SYLoginViewController.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/26.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYLoginViewController.h"

@interface SYLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginViewLeftMargin;

@end

@implementation SYLoginViewController


// 设置状态栏的。。
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)showLoginOrRegister:(UIButton *)button {
    
    [self.view endEditing:YES];
    
    if (self.LoginViewLeftMargin.constant == 0 ) {
        self.LoginViewLeftMargin.constant =  - self.view.width;
        button.selected = YES;
    }else{
        self.LoginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
//    self.phoneFiled.attributedPlaceholder = placeholder;
//    
    //
//    NSMutableAttributedString *placehoder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
//    
//    
//    [placehoder setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(0, 1)];
//    [placehoder setAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} range:NSMakeRange(1, 1)];
//    [placehoder setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} range:NSMakeRange(2, 1)];
//       self.phoneFiled.attributedPlaceholder = placehoder;
    //    // 带有属性的文字


    
    
    
    
    
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
