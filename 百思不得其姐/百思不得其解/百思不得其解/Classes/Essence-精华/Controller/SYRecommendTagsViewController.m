//
//  SYRecommendTagsViewController.m
//  百思不得其解
//
//  Created by 孙寅 on 15/7/28.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "SYRecommendTagsViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "SYRecommendTag.h"
#import "SYRecommendTagCell.h"
@interface SYRecommendTagsViewController ()
/** 标签数据 */
@property (nonatomic, strong)NSArray *tags;

@end

@implementation SYRecommendTagsViewController

static NSString * const SYTagsId = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
    
}

- (void)loadTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
//    请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        self.tags = [SYRecommendTag objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
        
}

- (void)setupTableView
{
    self.title = @"推荐标签";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:SYTagsId];

    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = SYGlobalBg;
    
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:SYTagsId];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}


@end
