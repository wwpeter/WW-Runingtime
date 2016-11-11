//
//  User.m
//  runtime
//
//  Created by 何元博 on 2016/10/27.
//  Copyright © 2016年 heyuanbo. All rights reserved.
//

#import "User.h"

@implementation User

+(User *)exchangeUserModelWithDictionary:(NSDictionary *)dict {
    
    User *user = [[self alloc] init];
    unsigned int count = 0;
    
    //获取属性列表
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //获取到每一个属性的名字，然后去掉前面的下划线
        ivarName = [ivarName substringFromIndex:1];
        NSLog(@"%@", ivarName);
        
        id value = dict[ivarName];
        //判断value是不是字典
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            NSLog(@"%@", type);
            NSArray *stringArray = [type componentsSeparatedByString:@"\""];
            NSLog(@"0:%@ 1:%@ 2:%@", stringArray[0] ,stringArray[1], stringArray[2]);
            Class class = NSClassFromString(stringArray[1]);
            if (class) {
                value = [class exchangeUserModelWithDictionary:value];
            }
        }
        
        //使用KVC直接进行赋值
        [user setValue:value forKey:ivarName];
    }
    return user;
}


@end
