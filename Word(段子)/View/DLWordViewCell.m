//
//  DLWordViewCell.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/28.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLWordViewCell.h"
#import "DLWordItem.h"


@interface DLWordViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *addTime;
@property (weak, nonatomic) IBOutlet UILabel *content;


@end


@implementation DLWordViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.autoresizingMask = NO;
    self.content.numberOfLines = 0;
    self.content.preferredMaxLayoutWidth = DLScreenWidth - 4 * DLMargin;
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_background"]];
}
//设置模型数据
- (void)setWord:(DLWordItem *)word
{
    _word = word;
    //时间
    self.addTime.text = word.addtime;
    //#warning 对时间显示做一下处理
    //内容
    self.content.text = word.content;
    
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
