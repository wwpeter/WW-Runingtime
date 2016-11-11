//
//  User.h
//  runtime
//
//  Created by 何元博 on 2016/10/27.
//  Copyright © 2016年 heyuanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface User : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *homeAddress;
@property (nonatomic, assign)NSNumber *age;
@property (nonatomic, assign)NSNumber *weight;
@property (nonatomic, retain)User *user;
+(User *)exchangeUserModelWithDictionary:(NSDictionary *)dict;

@end
