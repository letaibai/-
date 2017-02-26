//
//  DLNavViewController.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/25.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLNavViewController.h"
#import "DLSegmentControl.h"
#import "DLWordViewController.h"
#import "DLPictureViewController.h"

@interface DLNavViewController ()

#define DLHeight 64

@property (nonatomic,strong) DLPictureViewController *picture;
@property (nonatomic,strong) DLWordViewController  *word;

@end

@implementation DLNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self preferredStatusBarStyle];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.picture = [[DLPictureViewController alloc] initWithStyle:UITableViewStylePlain];
    self.picture.view.frame = CGRectMake(0, DLHeight, self.view.frame.size.width, self.view.frame.size.height - DLHeight);
    [self.view addSubview:self.picture.view];
    [self addChildViewController:_picture];
    
    
    self.word = [[DLWordViewController alloc] initWithStyle:UITableViewStylePlain];
    self.word.view.frame = CGRectMake(0, DLHeight, self.view.frame.size.width, self.view.frame.size.height - DLHeight);
    [self.view addSubview:self.word.view];
    [self addChildViewController:_word];
}

- (void)setup
{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];
    NSArray *arr = @[@"段子",@"趣图"];
    
    DLSegmentControl *seg = [[DLSegmentControl alloc] initWithItems:arr];
    seg.center = self.navigationBar.center;
    seg.bounds = CGRectMake(0, 0, 150, 30);
    seg.apportionsSegmentWidthsByContent = YES;
    [seg addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.navigationBar addSubview:seg];
}
//点击了segmentControl的选项卡
- (void)change:(DLSegmentControl *)segmentControl
{
    switch (segmentControl.selectedSegmentIndex) {
            //点击了段子选项
        case 0:
        {
            NSLog(@"%s0----",__func__);
            self.picture.view.hidden = YES;
            self.word.view.hidden = NO;
        }
            break;
            //点击了趣图选项
       case 1:
        {
            NSLog(@"%s1----",__func__);
            self.word.view.hidden = YES;
            self.picture.view.hidden = NO;
           
        }
            break;
    }
}

//preferredStatusBarStyle
//返回状态栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
