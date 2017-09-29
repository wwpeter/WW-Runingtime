//
//  Person.h
//  WWData
//
//  Created by wangwei on 2017/9/29.
//  Copyright © 2017年 wangwei-WW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *picUrls;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, assign) float score;

@property (nonatomic, strong) NSNumber *number;

- (void)demo;
@end
