//
//  SecondViewController.m
//  WWData
//
//  Created by wangwei on 2017/9/29.
//  Copyright © 2017年 wangwei-WW. All rights reserved.
//

#import "SecondViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface SecondViewController ()
{
    unsigned int couont;
}
@end

@implementation SecondViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    couont = 0;
    [self test5];
    //[self test1];
    //[self test4];
    [self test2];
    //[self test3];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.获取Person中所有的方法名称
    [self test4];
}
//1.获取Person中所有的方法名称
-(void)test1{
    
    /**
     *  第一参数:需要获取的类
     第二个参数:获取到的个数
     */
    Method *methds =  class_copyMethodList([Person class], &couont);
    for (int i=0; i<couont; i++) {
        //1.获取遍历得到方法名
        SEL m = method_getName(methds[i]);
        //2.将方法名称转换为字符串
        NSString *methodName = NSStringFromSelector(m);
        //3.输出
        NSLog(@"%@",methodName);
    }
    
}
//成员变量
-(void)test2{
    Ivar *var = class_copyIvarList([Person class], &couont);
    for (int i = 0; i < couont; i++) {
        // 1.获取遍历到得成员变量名称
        const char *varName = ivar_getName(var[i]);
        // 2.将变量名称转换为字符串
        NSString *name = [NSString stringWithUTF8String:varName];
        // 3.输出
        NSLog(@"%@", name);
    }
    
}
//属性
-(void)test3{
    objc_property_t *propertes = class_copyPropertyList([Person class], &couont);
    for (int i = 0; i < couont; i++) {
        // 1.获取遍历到得属性名称
        const char * propertyName =  property_getName(propertes[i]);
        // 2.将属性名称转换为字符串
        NSString *name = [NSString stringWithUTF8String:propertyName];
        // 3.输出
        NSLog(@"%@", name);
    }
    
}
//解归档
-(void)test4{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *pathStr = [path stringByAppendingPathComponent:@"person.plist"];
    
    Person *p2 = [NSKeyedUnarchiver unarchiveObjectWithFile:pathStr];
    NSLog(@"name = %@ score = %lf  arr = %@",p2.className,p2.score,p2.picUrls);
}
- (NSString *)description {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *pathStr = [path stringByAppendingPathComponent:@"person.plist"];
    
    Person *p2 = [NSKeyedUnarchiver unarchiveObjectWithFile:pathStr];
    //NSLog(@"%@",p2);
    return [NSString stringWithFormat:@"%@",p2];
}
//归档
-(void)test5{
    Person *p = [[Person alloc] init];
    p.score = 155.8;
    p.className = @"wangwei";
    p.picUrls = @[@"1255553", @"4555556"];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *pathStr = [path stringByAppendingPathComponent:@"person.plist"];
    [NSKeyedArchiver archiveRootObject:p toFile:pathStr];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
