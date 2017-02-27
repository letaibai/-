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
    [self loadNewData];
    self.view.backgroundColor = [UIColor greenColor];
//    [self.tableView registerClass:[DLPictureViewCell class] forCellReuseIdentifier:ID];
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLPictureViewCell class]) bundle:nil forCellReuseIdentifier:ID]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLPictureViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    //发送网络请求
    
}
//- (NSArray *)pictureItems
//{
//    if (_pictureItems == nil) {
//        _pictureItems = [NSArray array];
//    }
//    return _pictureItems;
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//}
#pragma mark - 请求网络数据
/*
 * 加载新数据
 */
- (void)loadNewData
{
    //发送网络请求
    NSString *url = @"http://api.jisuapi.com/xiaohua/all";
    NSDictionary *params = @{@"pagenum"  : @1,
                             @"pagesize" : @20,
                             @"sort"     : @"addtime",
                             @"appkey"   : @"bf0ea749ff603575"
                            };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
         NSLog(@"请求成功");
        [responseObject writeToFile:@"/Users/davelee/Desktop/all.plist" atomically:YES];
        self.pictureItems = [DLPictureItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
        NSLog(@"%@",_pictureItems);
//        self.pictureItems = pic;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
   
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    NSLog(@"%lu --------",(unsigned long)self.pictureItems.count);
    return self.pictureItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLPictureViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DLPictureViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"%@------",self.pictureItems[indexPath.row]);
    cell.picture = self.pictureItems[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
@end
