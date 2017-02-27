//
//  DLPictureItem.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/26.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLPictureItem.h"

@implementation DLPictureItem

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
//        CGFloat textX = 10;
        CGFloat textY = 40;
        CGFloat textW = [UIScreen mainScreen].bounds.size.width - 3 * DLMargin;
        CGFloat textH = [self.content boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight = textY + textH + DLMargin;
    }
    
    return _cellHeight;
}

@end
