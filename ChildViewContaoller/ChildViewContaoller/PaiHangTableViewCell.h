//
//  PaiHangTableViewCell.h
//  YT_customer
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 sairongpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstRankingModel.h"

@protocol PaiHangCellDelegate <NSObject>

- (void)didPraise:(UIButton *)button callNumber:(NSString *)str;

@end
#define paihang @"paihangCellID"
@interface PaiHangTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *mingciLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *coolNumber;

@property (nonatomic, weak) id<PaiHangCellDelegate> delegate;

@property (nonatomic) FirstRankingModel *rankingModel;

@end
