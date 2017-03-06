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

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
//    发送网络请求
    [self setupRefresh];
}
//初始化
- (void)setup
{
    self.view.frame = CGRectMake(0, DLHeight, DLScreenWidth, DLScreenHeight - DLHeight);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, DLMargin,0);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"setting_press"] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLItemCell class]) bundle:nil] forCellReuseIdentifier:ID];
    //添加广告view
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, DLScreenHeight - Height, self.view.dl_width,Height )];
//    v.backgroundColor = [UIColor redColor];
//    [[[UIApplication sharedApplication].windows lastObject] addSubview:v];
}
#pragma mark - 点击了导航栏左侧的设置按钮
- (void)settingClick:(UIBarButtonItem *)item
{
    
}

//消除控制器警告
- (DLType)dl_type
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
    if (self.dl_type == DLTypeWord) {
        url = @"http://api.jisuapi.com/xiaohua/text";
    }else if(self.dl_type == DLTypePicture){
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
        
        //尝试下载图片并获取图片的宽高
        [self typeForVc];
        
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
    NSString *url = [self httpHead];
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
        
        [self typeForVc];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        page ++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//设置控制器的type
- (void)typeForVc
{
    for (int i = 0; i < self.items.count; i++) {
        DLItem *item = self.items[i];
        item.type = self.dl_type;
    }
}
#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DLItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.item = self.items[indexPath.row];
    
    return cell;
}
//返回tableView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLItem *item = self.items[indexPath.row];
    return item.cellHeight;
}
//返回tableView的估算高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

#pragma mark - TableViewDelegate
//选中tableView的某一行
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//UIMenuController
@end
