//
//  ADViewController.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/24.
//  Copyright © 2017年 李卫. All rights reserved.
/*  1.打开APP时,显示广告界面

    2.右上角按钮显示跳过按钮,并随着时间显示剩余秒数,秒数为0时,直接跳转至主页界面.

    3.用户点击跳过按钮,可直接跳转至主页界面.

    4.界面上的ImageView控件通过加载网络数据来显示广告图片

    5.用户点击此广告图片会跳转至Safari浏览器打开对应的URL网址
 */
//

#import "ADViewController.h"
#import "DLNavViewController.h"
#import "DLWordViewController.h"

@interface ADViewController ()
/** 显示广告的ImageView  */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 定时器  */
@property (nonatomic,strong) NSTimer *timer;
/** 跳过按钮  */
@property (weak, nonatomic) IBOutlet UIButton *jumpToHome;

@end

@implementation ADViewController
/** 跳过按钮的时间  */
static int leftTime = 3;

- (void)viewDidLoad {
    [super viewDidLoad];
    //启动定时器.每隔1s调用一次timeChange方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self.timer fire];
    [self setUp];
    [self preferredStatusBarStyle];
}
//初始化
- (void)setUp
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.imageView setUserInteractionEnabled:YES];
    [self.imageView addGestureRecognizer:tap];
//    self.imageView 
}
//点击了imageView调用的方法
- (void)tap:(UIImageView *)imageView
{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com" ];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@YES} completionHandler:^(BOOL success) {
//            NSLog(@"打开了百度主页");
        }];
       }
}

/*
 * 点击跳过按钮到主页
 */
- (IBAction)jumpToHome:(id)sender {
    DLWordViewController *word = [[DLWordViewController alloc] init];
    DLNavViewController *DLTabVc = [[DLNavViewController alloc] initWithRootViewController:word];
    [UIApplication sharedApplication].keyWindow.rootViewController = DLTabVc;
    //销毁定时器
    [self.timer invalidate];
}
/*
 * 每隔1s调用一次timeChange方法
 */
- (void)timeChange
{
    [self.jumpToHome setTitle:[NSString stringWithFormat:@"跳过 (%dS)",leftTime--] forState:UIControlStateNormal];
    /** 当计时器为0时,跳转至主页控制器  */
    if (leftTime < 0) {
        [self jumpToHome:nil];
    }
}
- (void)dealloc
{
    /** 销毁定时器  */
    [self.timer invalidate];
}
//修改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
