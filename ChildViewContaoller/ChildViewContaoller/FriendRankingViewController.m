//
//  FriendRankingViewController.m
//  YT_customer
//
//  Created by mac on 16/2/18.
//  Copyright © 2016年 sairongpay. All rights reserved.
//

#import "FriendRankingViewController.h"
#import "PaiHangTableViewCell.h"
#import "BusinessTableViewCell.h"

@interface FriendRankingViewController () <UITableViewDataSource,UITableViewDelegate,PaiHangCellDelegate>

@property (nonatomic) UITableView *onTableView;
@property (nonatomic) UITableView *underTableView;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSMutableArray *shopDataArray;
@end

@implementation FriendRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self createTableVeiw];
    [self loadSourseData];
}

- (void)loadSourseData {
    [self.onTableView reloadData];
    [self.underTableView reloadData];
}

- (void)createTableVeiw {
    _onTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height - 64-44-49)/2.0)];
    _onTableView.delegate = self;
    _onTableView.dataSource = self;
    _onTableView.showsHorizontalScrollIndicator = NO;
    _onTableView.showsVerticalScrollIndicator = NO;
    //注册
    //注册
    [_onTableView registerNib:[UINib nibWithNibName:@"PaiHangTableViewCell" bundle:nil] forCellReuseIdentifier:paihang];
    [self.view addSubview:_onTableView];
    //下面的tableView
    CGFloat height = (self.view.frame.size.height - 64-44-49)/2.0;
    _underTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, height, self.view.frame.size.width, height)];
    _underTableView.delegate = self;
    _underTableView.dataSource = self;
    _underTableView.showsHorizontalScrollIndicator = NO;
    _underTableView.showsVerticalScrollIndicator = NO;
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    myView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 4, 100, 12)];
    [label setText:@"土豪商家"];
    label.font = [UIFont systemFontOfSize:14];
    UILabel *redLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 3, 2, 14)];
    redLabel.backgroundColor = [UIColor redColor];
    [myView addSubview:redLabel];
    [myView addSubview:label];
    self.underTableView.tableHeaderView = myView;
    //注册
    [_underTableView registerNib:[UINib nibWithNibName:@"BusinessTableViewCell" bundle:nil] forCellReuseIdentifier:businessCellID];
    [self.view addSubview:_underTableView];
}
#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)shopDataArray {
    if (_shopDataArray == nil) {
        _shopDataArray = [NSMutableArray array];
    }
    return _shopDataArray;
}

#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _onTableView) {
        //return self.dataArray.count;
        return 11;
    } else {
       // return self.shopDataArray.count;
        return 5;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _onTableView) {
        PaiHangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:paihang];
        cell.myImageView.image = [UIImage imageNamed:@"yt_jiudian.png"];
        cell.userName.text = @"布依布舍007";
        cell.mingciLabel.text = [NSString stringWithFormat:@"第%d名",arc4random()%20];
        cell.moneyLabel.text = @"8888";
        cell.coolNumber.text = @"9";
        
        cell.delegate = self;
        
        return cell;
    } else {
        BusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:businessCellID];
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _onTableView) {
        return 60;
    } else {
        return 80;
    }
}

#pragma mark - setter and getter方法
- (UITableView *)onTableView {
    if (!_onTableView) {
        _onTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+44, self.view.frame.size.width, (self.view.frame.size.height - 64-44-49)/2.0)];
        _onTableView.delegate = self;
        _onTableView.dataSource = self;
        _onTableView.showsHorizontalScrollIndicator = NO;
        _onTableView.showsVerticalScrollIndicator = NO;
        //注册
        [_onTableView registerNib:[UINib nibWithNibName:@"PaiHangTableViewCell" bundle:nil] forCellReuseIdentifier:paihang];
    }
    return _onTableView;
}

- (UITableView *)underTableView {
    if (!_underTableView) {
        CGFloat height = (self.view.frame.size.height - 64-44-49)/2.0;
        _underTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+44+height, self.view.frame.size.width, height)];
        _underTableView.delegate = self;
        _underTableView.dataSource = self;
        _underTableView.showsHorizontalScrollIndicator = NO;
        _underTableView.showsVerticalScrollIndicator = NO;
        //注册
        [_underTableView registerNib:[UINib nibWithNibName:@"BusinessTableViewCell" bundle:nil] forCellReuseIdentifier:businessCellID];
    }
    return _underTableView;
}

- (void)didPraise:(UIButton *)button callNumber:(NSString *)str {
    NSLog(@"这里是排行榜！！");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
