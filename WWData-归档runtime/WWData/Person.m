//
//  Person.m
//  WWData
//
//  Created by wangwei on 2017/9/29.
//  Copyright © 2017年 wangwei-WW. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
{
    int _age;
    double _height;
    NSString *_name;
}
- (void)test
{
    NSLog(@"%s", __func__);
}

- (void)demo
{
    NSLog(@"%s", __func__);
    
}
- (void)dealloc {
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历的属性
    for (int i=0; i<count; i++) {
        //获取当前遍历的属性的名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        //利用KVC取出对应属性的值
        id value = [self valueForKey:name];
        //归档到文件中
        [aCoder encodeObject:value forKey:name];
    }
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count =0;
        //1.取出所有的属性
        objc_property_t *propertes = class_copyPropertyList([self class], &count);
        //2.遍历所有的属性
        for (int i = 0; i < count; i++) {
            //获取当前遍历到的属性名称
            const char *propertyName = property_getName(propertes[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            //解归档前遍历得到的属性的值
            id value = [aDecoder decodeObjectForKey:name];
            //             self.className = [decoder decodeObjectForKey:@"className"];
            [self setValue:value forKey:name];
        }
    }
    return self;
}

/*
 - (void)encodeWithCoder:(NSCoder *)encoder
 {
 [encoder encodeObject:self.picUrls forKey:@"picUrls"];
 [encoder encodeObject:@(self.score) forKey:@"score"];
 [encoder encodeObject:self.className forKey:@"className"];
 }
 
 - (id)initWithCoder:(NSCoder *)decoder
 {
 if (self = [super init]) {
 self.picUrls = [decoder decodeObjectForKey:@"picUrls"];
 self.score = [[decoder decodeObjectForKey:@"score"] doubleValue];
 self.className = [decoder decodeObjectForKey:@"className"];
 }
 return self;
 }
 */
@end
