//
//  DLLabel.m
//  段子内涵图
//
//  Created by 李卫 on 2017/3/6.
//  Copyright © 2017年 李卫. All rights reserved.
//  可复制文字的Label空间

#import "DLLabel.h"



@implementation DLLabel

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return action == @selector(copy:);
}
- (void)copy:(id)sender
{
    UIPasteboard *paseboard = [UIPasteboard generalPasteboard];
    paseboard.string = self.text;
}

- (void)attachTapHandler
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

-(void)handleTap:(UIGestureRecognizer *)recognizer
{
    [self becomeFirstResponder];
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copy:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:item, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self attachTapHandler];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self attachTapHandler];
}
@end
