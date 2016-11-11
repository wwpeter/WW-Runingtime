//
//  UIImage+category.m
//  runtime
//
//  Created by 何元博 on 16/10/14.
//  Copyright © 2016年 heyuanbo. All rights reserved.
//

#import "UIImage+category.h"
#import <objc/runtime.h>

@implementation UIImage (category)

+ (UIImage *)new_imageNamed:(NSString *)name {
    NSLog(@"方法名称%s,%@", __func__, name);
    //在这重新给字符串name赋值，从而改变图片文件
    name = @"image2.png";
    UIImage *image = [UIImage new_imageNamed:name];
    return image;
}

//在load的时候就更换这两个方法
+ (void)load {
    Method method1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method method2 = class_getClassMethod([UIImage class], @selector(new_imageNamed:));
    method_exchangeImplementations(method1, method2);
}
@end
