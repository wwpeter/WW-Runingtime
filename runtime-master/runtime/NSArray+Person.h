//
//  NSArray+Person.h
//  runtime
//
//  Created by 何元博 on 16/10/14.
//  Copyright © 2016年 heyuanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface NSArray (Person)
@property (nonatomic, strong)Person *person;
- (Person *)person;
- (void)setPerson:(Person *)person;
@end
