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
#import <MJRefresh.h>



#define SYSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
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
  
    [self setupRefresh];
    
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


- (void)setupRefresh
{
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.footer.hidden = YES;
}

- (void)loadMoreUsers
{
    SYRecommendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSArray *users = [SYRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [category.user addObjectsFromArray:users];
        
        [self.userTableView reloadData];
        
        if (category.user.count == category.total) {
            [self.userTableView.footer noticeNoMoreData];
        }else
        {
            [self.userTableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        SYLog(@"%@", error);
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    else
    {
        NSInteger count = [SYSelectedCategory users].count;
        // 每次刷新表格，控制footer显示或者隐藏
        self.userTableView.footer.hidden = (count == 0);
        return count;
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

#pragma mark -- <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYRecommendCategory *c = self.categories[self.userTableView.indexPathForSelectedRow.row];
    
    if (c.user.count) {
        [self.userTableView reloadData];
    } else
    {
        [self.userTableView reloadData];
        
        c.currentPage = 1;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *users = [SYRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
// 添加到当前类别对应的用户数组中
            [c.user addObjectsFromArray:users];
            // 保存总数
            c.total = [responseObject[@"total"] integerValue];
            
            [self.userTableView reloadData];
            
            if (c.user.count == c.total) {
                [self.userTableView.footer noticeNoMoreData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            SYLog(@"%@",error);
        }];

    }
    
}






@end
