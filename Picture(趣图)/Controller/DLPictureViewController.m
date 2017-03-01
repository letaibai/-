//
//  DLPictureViewController.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/25.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLPictureViewController.h"

@interface DLPictureViewController ()

@property(nonatomic,strong) NSMutableArray *pictureItems;

@end

@implementation DLPictureViewController
//返回子控制器的类型
- (DLType)type
{
    return DLTypePicture;
}
@end
