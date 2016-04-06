//
//  PaiHangTableViewCell.m
//  YT_customer
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 sairongpay. All rights reserved.
//

#import "PaiHangTableViewCell.h"


@implementation PaiHangTableViewCell
- (IBAction)zanButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didPraise:callNumber:)]) {
        [self.delegate didPraise:sender callNumber:@""];
    }
}

- (void)setRankingModel:(FirstRankingModel *)rankingModel {
    if (_rankingModel != rankingModel) {
       //配置cell的内容
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
