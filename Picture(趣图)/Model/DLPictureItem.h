//
//  DLPictureItem.h
//  段子内涵图
//
//  Created by 李卫 on 2017/2/26.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLPictureItem : NSObject

/*
 图片返回内容
 total	string	总数
 pagenum	int	当前页
 pagesize	int	每页条数
 content	string	内容
 pic	string	图片
 addtime	string	时间
 url	string	详情页地址
 */
/** 总数  */
@property (nonatomic,strong) NSString *total;
/** 当前页  */
@property (nonatomic,assign) int pagenum;
/** 每页条数  */
@property (nonatomic,assign) int pagesize;
/** 内容  */
@property (nonatomic,strong) NSString *content;
/** 图片  */
@property (nonatomic,strong) NSString *pic;
/** 时间  */
@property (nonatomic,strong) NSString *addtime;

/** 详情页地址  */
@property (nonatomic,strong) NSString *url;
///** cell的高度  */
@property (nonatomic,assign) CGFloat cellHeight;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
