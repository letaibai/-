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

@interface DLItemCell ()
/** 发布时间  */
@property (weak, nonatomic) IBOutlet UILabel *addTime;
/** 内容  */
@property (weak, nonatomic) IBOutlet UILabel *content;
/** 图片  */
@property (weak, nonatomic) IBOutlet UIImageView *pic;



@end

@implementation DLItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.autoresizingMask = NO;
    self.content.preferredMaxLayoutWidth = DLScreenWidth - 4 * DLMargin;
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_background"]];
}
//设置模型数据
- (void)setPicture:(DLItem *)picture
{
    _picture = picture;
    if (picture.type == DLTypePicture) {
        self.pic.hidden = NO;
        [self.pic sd_setImageWithURL:[NSURL URLWithString:picture.pic] placeholderImage:[UIImage imageNamed:@"img_default"]];
    }else if(picture.type == DLTypeWord){
        self.pic.hidden = YES;
    }
    //时间
    self.addTime.text = picture.addtime;
    //#warning 对时间显示做一下处理
    //内容
    self.content.text = picture.content;
    [self layoutIfNeeded];
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = DLMargin;
    frame.origin.y += DLMargin;
    frame.size.width -= 2 * DLMargin;
    frame.size.height -= DLMargin;
    [super setFrame:frame];
}
@end
