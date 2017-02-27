//
//  UIView+DLFrame.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/27.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "UIView+DLFrame.h"

@implementation UIView (DLFrame)

- (CGFloat)dl_x
{
    return self.frame.origin.x;
}

- (CGFloat)dl_y
{
    return self.frame.origin.y;
}

- (CGFloat)dl_width
{
    return self.frame.size.width;
}

- (CGFloat)dl_height
{
    return self.frame.size.height;
}

- (CGFloat)dl_centerX
{
    return self.center.x;
}
- (CGFloat)dl_centerY
{
    return self.center.y;
}

- (void)setDl_x:(CGFloat)dl_x
{
    CGRect rect = self.frame;
    rect.origin.x = dl_x;
    self.frame = rect;
}
- (void)setDl_y:(CGFloat)dl_y
{
    CGRect rect = self.frame;
    rect.origin.y = dl_y;
    self.frame = rect;
}
- (void)setDl_width:(CGFloat)dl_width
{
    CGRect rect = self.frame;
    rect.size.width = dl_width;
    self.frame = rect;
}
- (void)setDl_height:(CGFloat)dl_height{
    CGRect rect = self.frame;
    rect.size.height = dl_height;
    self.frame = rect;
}
- (void)setDl_centerX:(CGFloat)dl_centerX{
    CGPoint center = self.center;
    center.x = dl_centerX;
    self.center = center;
}
- (void)setDl_centerY:(CGFloat)dl_centerY
{
    CGPoint center = self.center;
    center.y = dl_centerY;
    self.center = center;
}


@end
