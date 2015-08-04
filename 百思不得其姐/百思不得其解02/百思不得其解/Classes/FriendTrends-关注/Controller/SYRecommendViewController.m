//
//  SYRecommendViewController.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/23.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "SYRecommendCategoryCell.h"
#import "SYRecommendCategory.h"
#import <MJExtension.h>
#import "SYRecommendUser.h"
#import "SYRecomminUserCell.h"

@interface SYRecommendViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 左边的类别数据 */
@property (nonatomic, strong)NSArray *categories;
/** 右边的用户数据 */
@property (nonatomic, strong)NSArray *users;

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;


@end

@implementation SYRecommendViewController

static NSString * const SYCategroyID = @"category";
static NSString * const SYUserID = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    [self sendRequest];
  
    
    
   }
- (void)setupTableView
{
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYRecomminUserCell class]) bundle:nil] forCellReuseIdentifier:SYUserID];
    
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:SYCategroyID];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    
    self.title =@"推荐关注";
    self.view.backgroundColor =SYGlobalBg;
}

- (void)sendRequest
{
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        self.categories = [SYRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        NSLog(@"viewDidLoad--------%zd",self.categories.count);
        
        
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    else
    {
        return self.users.count;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.categoryTableView) {
        SYRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:SYCategroyID];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{
        SYRecomminUserCell *cell = [tableView dequeueReusableCellWithIdentifier:SYUserID];
        SYRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        
        cell.user = c.user[indexPath.row];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYRecommendCategory *c = self.categories[self.userTableView.indexPathForSelectedRow.row];
    
    if (c.user.count) {
        [self.userTableView reloadData];
    } else
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            self.users = [SYRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            SYLog(@"%@",error);
        }];

    }
    
}






@end
