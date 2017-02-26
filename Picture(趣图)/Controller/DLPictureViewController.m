//
//  DLPictureViewController.m
//  段子内涵图
//
//  Created by 李卫 on 2017/2/25.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "DLPictureViewController.h"

@interface DLPictureViewController ()

@end

@implementation DLPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"picture"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picture" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"picture"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}


@end
