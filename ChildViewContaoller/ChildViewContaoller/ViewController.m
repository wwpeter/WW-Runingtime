//
//  ViewController.m
//  ChildViewContaoller
//
//  Created by ww on 16/4/6.
//  Copyright © 2016年 ww. All rights reserved.
//

#import "ViewController.h"
#import "RankingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController];
}
- (void)addChildViewController {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"child" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 150, 150);
    button.center = self.view.center;
    button.backgroundColor = [UIColor redColor];;
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}
- (void)click:(UIButton *)button {
    RankingViewController *controller = [[RankingViewController alloc] init];
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
