//
//  Person.m
//  runtime
//
//  Created by 何元博 on 16/10/14.
//  Copyright © 2016年 heyuanbo. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)instanceStudy {
    NSLog(@"发送对象消息~~ %s 对象方法study", __func__);
}

- (void)instanceRun {
    NSLog(@"发送对象消息~~ %s 对象方法run", __func__);
}

+ (void)classStudy {
    NSLog(@"发送类消息~~ %s 类方法study", __func__);
}

+ (void)classRun {
    NSLog(@"发送类消息~~ %s 类方法run", __func__);
}
@end
