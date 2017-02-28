//
//  DLWordTableViewController.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/25.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLWordViewController.h"
#import "DLWordViewCell.h"
#import "DLWordItem.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>

@interface DLWordViewController ()

@property(nonatomic,strong) NSMutableArray *wordItems;

@end

@implementation DLWordViewController

static NSString *ID = @"word";
static int page = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
    //    发送网络请求
    [self setupRefresh];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLWordViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

#pragma mark - 请求网络数据

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_footer setAutomaticallyHidden:YES];
}

/*
 * 加载新数据
 */
- (void)loadNewData
{
    [self.tableView.mj_footer endRefreshing];
    //发送网络请求
    NSString *url = @"http://api.jisuapi.com/xiaohua/text";
    NSDictionary *params = @{@"pagenum"  : @1,
                             @"pagesize" : @20,
                             @"sort"     : @"addtime",
                             @"appkey"   : @"bf0ea749ff603575"
                             };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //字典转模型
        self.wordItems = [DLWordItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
        //        [responseObject writeToFile:@"/Users/davelee/Desktop/pic.plist" atomically:YES];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
/*
 * 加载更多数据
 */
- (void)loadMoreData
{
    [self.tableView.mj_header endRefreshing];
    //发送网络请求
    NSString *url = @"http://api.jisuapi.com/xiaohua/text";
    NSDictionary *params = @{@"pagenum"  : @(page),
                             @"pagesize" : @20,
                             @"sort"     : @"addtime",
                             @"appkey"   : @"bf0ea749ff603575"
                             };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //字典转模型
        NSArray *arr = [DLWordItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
        [responseObject writeToFile:@"/Users/davelee/Desktop/text.plist" atomically:YES];
        [self.wordItems addObjectsFromArray:arr];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        page ++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wordItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLWordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DLWordViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.word = self.wordItems[indexPath.row];
    [cell layoutIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLWordItem *item = self.wordItems[indexPath.row];
//    [tableView layoutIfNeeded];
//    NSLog(@"%zd",item.cellHeight);
    return item.cellHeight;
}
//返回tableView的估算高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


@end
