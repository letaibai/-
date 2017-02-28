//
//  DLPictureViewController.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/25.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLPictureViewController.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "DLPictureItem.h"
#import "DLPictureViewCell.h"



@interface DLPictureViewController ()

@property(nonatomic,strong) NSArray *pictureItems;

@end

@implementation DLPictureViewController

//- (NSArray *)pictureItems
//{
//    if (!_pictureItems) {
//        NSString *str = [[NSBundle mainBundle] pathForResource:@"pic" ofType:@"plist"];
//        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:str];
//        NSArray *arr = dict[@"result"][@"list"];
//        NSMutableArray *picArr = [NSMutableArray array];
//        for (NSDictionary *dict in arr) {
//            DLPictureItem *item = [DLPictureItem itemWithDict:dict];
//            [picArr addObject:item];
//            _pictureItems = picArr;
//        }
//    }
//    return _pictureItems;
//}

/*
 接口地址：
 http://api.jisuapi.com/xiaohua/all
 支持格式：
 JSON,JSONP
 请求方法：
 GET POST
 请求示例：
 http://api.jisuapi.com/xiaohua/all?pagenum=1&pagesize=1&sort=addtime&appkey=yourappkey
 请求参数：
 参数名称	类型	必填	说明
 appkey  ： bf0ea749ff603575
 pagenum	int	是	页码
 pagesize	int	是	每页条数 最大20
 sort	string	是	排序 addtime按时间倒叙 rand随机获取
 sort=rand时，pagenum无效
 */
static NSString *ID = @"picture";

- (void)viewDidLoad {
    [super viewDidLoad];
//    发送网络请求
    [self setupRefresh];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLPictureViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
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
    NSString *url = @"http://api.jisuapi.com/xiaohua/pic";
    NSDictionary *params = @{@"pagenum"  : @1,
                             @"pagesize" : @20,
                             @"sort"     : @"addtime",
                             @"appkey"   : @"bf0ea749ff603575"
                            };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //字典转模型
        self.pictureItems = [DLPictureItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
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
    NSString *url = @"http://api.jisuapi.com/xiaohua/pic";
    NSDictionary *params = @{@"pagenum"  : @2,
                             @"pagesize" : @20,
                             @"sort"     : @"addtime",
                             @"appkey"   : @"bf0ea749ff603575"
                             };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //字典转模型
        self.pictureItems = [DLPictureItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
        //        [responseObject writeToFile:@"/Users/davelee/Desktop/pic.plist" atomically:YES];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pictureItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLPictureViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DLPictureViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.picture = self.pictureItems[indexPath.row];
    
    return cell;
}
//返回tableView的估算高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLPictureItem *item = self.pictureItems[indexPath.row];
    return item.cellHeight;
}
@end
