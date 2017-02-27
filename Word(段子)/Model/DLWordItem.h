//
//  DLWordItem.h
//  段子内涵图
//
//  Created by 李卫 on 2017/2/26.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLWordItem : NSObject

/*
 文字返回内容
 total	string	总数
 pagenum	int	当前页
 pagesize	int	每页条数
 content	string	内容
 addtime	string	时间
 url	string	详情页地址
 */
/** 总数  */
@property (nonatomic,strong) NSString *total;
/** 当前  */
@property (nonatomic,assign) int pagenum;
/** 每页条数  */
@property (nonatomic,assign) int pagesize;
/** 内容  */
@property (nonatomic,strong) NSString *content;
/** 时间  */
@property (nonatomic,strong) NSString *addtime;
/** 详情页地址  */
@property (nonatomic,strong) NSString *url;


@end
