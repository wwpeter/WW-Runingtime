//
//  ViewController.h
//  runtime
//
//  Created by 何元博 on 16/10/14.
//  Copyright © 2016年 heyuanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

