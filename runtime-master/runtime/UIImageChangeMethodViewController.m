//
//  UIImageChangeMethodViewController.m
//  runtime
//
//  Created by 何元博 on 16/10/14.
//  Copyright © 2016年 heyuanbo. All rights reserved.
//

#import "UIImageChangeMethodViewController.h"

@interface UIImageChangeMethodViewController ()

@end

@implementation UIImageChangeMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, self.view.frame.size.width - 200, 200)];
    imageview.image = [UIImage imageNamed:@"image1.png"];
    [self.view addSubview:imageview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
