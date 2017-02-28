//
//  DLWordItem.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/26.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLWordItem.h"

@implementation DLWordItem


- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        
//        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"&nbsp;"];
//        NSMutableString *str = [NSMutableString stringWithString:self.content];
//        //去空格
//        NSRange range = {0,str.length - 1};
//        [str replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:range];
//        //去特殊字符
//        NSString *string = [str stringByTrimmingCharactersInSet:set];
////        NSLog(@"%@",string);
        
        CGFloat textY = 50;
        CGFloat textW = [UIScreen mainScreen].bounds.size.width - 4 * DLMargin;
        CGFloat textH = [self.content boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
//        CGFloat height = textH;
        
//        NSLog(@"%zd",height);
        _cellHeight = textY + textH + 4 * DLMargin;
      
     }
    return _cellHeight;
}

@end
