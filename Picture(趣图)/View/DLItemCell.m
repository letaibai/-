//
//  DLItemCell.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/26.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLItemCell.h"
#import "DLItem.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "DLShowPictureViewController.h"

@interface DLItemCell ()
/** 发布时间  */
@property (weak, nonatomic) IBOutlet UILabel *addTime;
/** 内容  */
@property (weak, nonatomic) IBOutlet UILabel *content;
/** 图片  */
@property (weak, nonatomic) IBOutlet UIImageView *pic;
/** 顶  */
@property (weak, nonatomic) IBOutlet UIButton *ding;
/** 按钮的状态  */
@property (assign, nonatomic) BOOL isSelect;
//点赞+1的图片
@property (strong, nonatomic)  UIImageView *ima;

@end

@implementation DLItemCell

static int count = 0 ;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.autoresizingMask = NO;
    //设置文字的最大宽度,更精确计算label的高度
    self.content.preferredMaxLayoutWidth = DLScreenWidth - 4 * DLMargin;
    self.backgroundColor = [UIColor clearColor];
    [self btnAddImageVc];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.pic.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)];
    [self.pic addGestureRecognizer:tap];
}
#pragma mark - 图片手势监听
- (void)showPicture
{
    DLShowPictureViewController *showPic = [[DLShowPictureViewController alloc] init];
    showPic.item = self.item;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPic animated:YES completion:nil];
    
}

#pragma mark - 设置模型数据
//设置模型数据
- (void)setItem:(DLItem *)item
{
    _item = item;
    
    if (item.type == DLTypeWord) {
        self.pic.hidden = YES;
    }else if(item.type == DLTypePicture){
        self.pic.hidden = NO;
        [self.pic sd_setImageWithURL:[NSURL URLWithString:item.pic] placeholderImage:[UIImage imageNamed:@"img_default"]];
    }
    //时间
    self.addTime.text = [self create_time:item];

    //内容
    self.content.text = item.content;
    [self layoutIfNeeded];
}
//对时间显示做一下处理
- (NSString *)create_time:(DLItem *)item
{
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子的创建时间
    NSDate *create = [fmt dateFromString:item.addtime];
    if (create.isThisYear) { //今年
        if (create.isToday) { //今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) {//时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            } else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            } else { //1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { //昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { //其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else {
        return item.addtime;
    }
}
#pragma mark - 设置cell的整体间距
//设置cell的整体间距
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = DLMargin;
    frame.origin.y += DLMargin;
    frame.size.width -= 2 * DLMargin;
    frame.size.height -= DLMargin;
    [super setFrame:frame];
}
#pragma mark - 工具条内容点击事件的监听
//收藏
- (IBAction)favoriteClick:(UIButton *)sender {
   if(sender.selected){
       sender.selected = NO;
       [SVProgressHUD showSuccessWithStatus:@"已取消收藏"];
   }else if(sender.highlighted){
       sender.selected = YES;
       [SVProgressHUD showSuccessWithStatus:@"已收藏"];
   }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
//添加点赞+1的图片
- (void)btnAddImageVc
{
    self.ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_one"]];
    self.ima.frame = CGRectMake(self.ding.dl_centerX - DLMargin, self.ding.dl_centerY - 2 * DLMargin, self.ima.dl_width, self.ima.dl_height);
    [self.ding addSubview:self.ima];
    self.ima.hidden = YES;
}
//分享
- (IBAction)share:(UIButton *)sender {
    
    
}
//点赞
- (IBAction)ding:(UIButton *)sender {
    if (sender.selected) {
        [SVProgressHUD showInfoWithStatus:@"您已经点过赞了!"];
    }else if(sender.highlighted){
        self.ima.hidden = NO;
        sender.selected = YES;
        count++;
        [sender setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateSelected];
        [sender setImage:[UIImage imageNamed:@"digupicon_btn_listpage_select"] forState:UIControlStateNormal];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.ima.hidden = YES;
        [SVProgressHUD dismiss];
    });
    //点赞+1的动画
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    [self.ima.layer addAnimation:animation forKey:nil];
}
@end
