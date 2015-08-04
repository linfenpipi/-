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

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, strong)NSMutableDictionary *params;

/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation SYRecommendViewController

static NSString * const SYCategroyID = @"category";
static NSString * const SYUserID = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    [self sendRequest];
  
    [self loadCategories];
}

- (void)loadCategories
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"category";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        
        self.categories = [SYRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
    
    
}

// 控件初始化
- (void)setupTableView
{
    // 注册
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYRecomminUserCell class]) bundle:nil] forCellReuseIdentifier:SYUserID];
    
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:SYCategroyID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // 设置标题
    self.title =@"推荐关注";
    // 背景色
    self.view.backgroundColor =SYGlobalBg;
}

// 添加刷新控件
- (void)setupRefresh
{
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];

}
- (void)loadNewUsers
{
    SYRecommendCategory *rc = SYSelectedCategory;
    
    rc.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *user = [SYRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [rc.users removeAllObjects];
        
        [rc.users addObjectsFromArray:user];
                         
        rc.total = [responseObject[@"total"] integerValue];
        
        if (self.params != params) {
            return;
        }
        [self.userTableView reloadData];
        
        [self.userTableView.header endRefreshing];
        
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
    
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.header endRefreshing];
    
    }];
    
}

- (void)checkFooterState
{
    SYRecommendCategory *rc = SYSelectedCategory;
    
    self.userTableView.footer.hidden = (rc.users.count == 0);
    
    if (rc.users.count == rc.total) {
        [self.userTableView.footer noticeNoMoreData];
    }else
    {
        [self.userTableView.footer endRefreshing];
    }
    
}


- (void)sendRequest
{
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        self.categories = [SYRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        
    }];

}



- (void)loadMoreUsers
{
    SYRecommendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSArray *users = [SYRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        if (self.params != params) {
            return;
        }
        
        [self.userTableView reloadData];
        
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        [self.userTableView.footer endRefreshing];
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
  
    [self checkFooterState];
    
    return [SYSelectedCategory users].count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.categoryTableView) {
        
        SYRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:SYCategroyID];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    
    }else{
        
        SYRecomminUserCell *cell = [tableView dequeueReusableCellWithIdentifier:SYUserID];
        
        cell.user = [SYSelectedCategory users][indexPath.row];
        
        return cell;
    }
    
}

#pragma mark -- <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.header endRefreshing];
    [self.userTableView.footer endRefreshing];
    
    SYRecommendCategory *c = self.categories[self.userTableView.indexPathForSelectedRow.row];
    
    if (c.users.count) {
        [self.userTableView reloadData];
    } else
    {
        [self.userTableView reloadData];
        
        [self.userTableView.header beginRefreshing];
    }
}

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}




@end
