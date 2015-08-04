//
//  SYTopicViewController.m
//  百思不得其解
//
//  Created by 孙寅 on 15/8/1.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYTopicViewController.h"
#import "SYWordViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "SYTopic.h"
#import "SYTopicCell.h"




@interface SYTopicViewController ()

/**  */
@property (nonatomic, strong)NSMutableArray *topics;

/**  */
@property (nonatomic, assign)NSInteger page;

/**  */
@property (nonatomic, copy)NSString *maxtime;
/**  */
@property (nonatomic, strong)NSDictionary *params;
@end

@implementation SYTopicViewController

- (NSString *)type
{
    return nil;
}

- (NSMutableArray *)topics
{
    if (!_topics)
    {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self setupRefresh];
}

static NSString * const SYTopicCellId = @"topic";
- (void)setUpTableView
{
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = SYTitlesViewH + SYTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYTopicCell class]) bundle:nil] forCellReuseIdentifier:SYTopicCellId];
    
    
}

- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    
}
- (void)loadNewTopics
{
    [self.tableView.footer endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = self.type;
    
    self.params = params;
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if (self.params != params) {
            return ;
        }
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [SYTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
        self.page = 0;
        //        [responseObject writeToFile:@"/Users/xiaomage/Desktop/duanzi.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return ;
        }
        [self.tableView.header endRefreshing];
    }];
    
}
- (void)loadMoreTopics
{
    
    [self.tableView.header endRefreshing];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (self.params != params) {
            return ;
        }
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *newTopics = [SYTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.footer endRefreshing];
        
        self.page = page;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return;
        }
        
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:SYTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
