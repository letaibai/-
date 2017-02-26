//
//  DLSegmentControl.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/25.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLSegmentControl.h"


@implementation DLSegmentControl
//初始化时调用
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self setup];
//    }
//    return self;
//}
//
- (void)setup
{
    //普通状态下文字颜色:白色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    //高亮状态下文字颜色:红色
    NSMutableDictionary *selDict =[NSMutableDictionary dictionary];
    selDict[NSForegroundColorAttributeName] = [UIColor colorWithRed:229/255.0 green:28/255.0 blue:35/255.0 alpha:1.0];
    selDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    
    //修改文字颜色
    //普通
    [self setTitleTextAttributes:dict forState:UIControlStateNormal];
    //高亮
    [self setTitleTextAttributes:selDict forState:UIControlStateHighlighted];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.selectedSegmentIndex = 0;
    self.tintColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
}
@end
