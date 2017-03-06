//
//  DLShowPictureViewController.m
//  段子内涵图
//
//  Created by 李卫 on 2017/3/4.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLShowPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "DLItem.h"
#import <SVProgressHUD.h>


@interface DLShowPictureViewController ()
@property (nonatomic,strong) UIImageView *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DLShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image = [[UIImageView alloc] init];
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:image];
    
    self.image = image;
    image.frame = CGRectMake(0, 0, DLScreenWidth, DLScreenHeight);
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.item.pic] placeholderImage:[UIImage imageNamed:@"img_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

//返回上一层控制器
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//保存图片
- (IBAction)save:(id)sender {
//    if(!self.image.image){
        UIImageWriteToSavedPhotosAlbum(self.image.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    }
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}
@end
