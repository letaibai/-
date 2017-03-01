//
//  DLBaseViewController.m
//  段子内涵图
//
//  Created by 李卫 on 2017/3/1.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLBaseViewController.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "DLItem.h"
#import "DLItemCell.h"
#import <UIImageView+WebCache.h>



@interface DLBaseViewController ()

@property(nonatomic,strong) NSMutableArray *items;

@end

@implementation DLBaseViewController

static NSString *ID = @"cell";

static int page = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
    //    发送网络请求
    [self setupRefresh];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLItemCell class]) bundle:nil] forCellReuseIdentifier:ID];
}
- (DLType)type
{
    return 2;
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
//返回请求头
- (NSString *)httpHead
{
    NSString *url;
    if (self.type == DLTypeWord) {
        url = @"http://api.jisuapi.com/xiaohua/text";
    }else if(self.type == DLTypePicture){
        url = @"http://api.jisuapi.com/xiaohua/pic";
    }
    return url;
}
/*
 * 加载新数据
 */
- (void)loadNewData
{
    [self.tableView.mj_footer endRefreshing];
    //发送网络请求
    NSString *url = [self httpHead];
    NSDictionary *params = @{@"pagenum"  : @1,
                             @"pagesize" : @20,
                             @"sort"     : @"addtime",
                             @"appkey"   : @"bf0ea749ff603575"
                             };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //字典转模型
        self.items = [DLItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
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
    NSString *url = @"http://api.jisuapi.com/xiaohua/pic";
    NSDictionary *params = @{@"pagenum"  : @(page),
                             @"pagesize" : @20,
                             @"sort"     : @"addtime",
                             @"appkey"   : @"bf0ea749ff603575"
                             };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //字典转模型
        NSArray *arr = [DLItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
        [self.items addObjectsFromArray:arr];
        //        [responseObject writeToFile:@"/Users/davelee/Desktop/pic.plist" atomically:YES];
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
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DLItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.picture = self.items[indexPath.row];
    
    return cell;
}
//返回tableView的估算高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLItem *item = self.items[indexPath.row];
    return item.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
@end
