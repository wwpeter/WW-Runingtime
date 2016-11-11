//
//  NSArray+Person.m
//  runtime
//
//  Created by 何元博 on 16/10/14.
//  Copyright © 2016年 heyuanbo. All rights reserved.
//

#import "NSArray+Person.h"
#import <objc/runtime.h>
@implementation NSArray (Person)

char *key;
- (void)setPerson:(Person *)person {
    objc_setAssociatedObject(self, key, person, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Person *)person {
    return objc_getAssociatedObject(self, key);
}
@end
