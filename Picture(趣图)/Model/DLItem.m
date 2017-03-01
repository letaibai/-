//
//  DLPictureItem.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/26.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLItem.h"

@implementation DLItem

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGFloat textY = 50;
        CGFloat textW = DLScreenWidth - 4 * DLMargin;
        CGFloat textH = [self.content boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight = textY + textH + 2 *DLMargin;
        if (self.type == DLTypePicture) {
            CGFloat imageY = textH;
            CGFloat imageH = textW * DLScreenHeight / DLScreenWidth;
            _cellHeight = imageY + imageH + 2* DLMargin;
        }
    }
    return _cellHeight;
}
@end
