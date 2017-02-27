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
    //发送网络请求
    [self loadNewData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLPictureViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

#pragma mark - 请求网络数据
/*
 * 加载新数据
 */
- (void)loadNewData
{
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
        self.pictureItems = [DLPictureItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
//        [responseObject writeToFile:@"/Users/davelee/Desktop/pic.plist" atomically:YES];
        [self.tableView reloadData];
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
    NSLog(@"%zd----",item.cellHeight);
    return item.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
@end
