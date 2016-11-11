//
//  ViewController.m
//  runtime
//
//  Created by 何元博 on 16/10/14.
//  Copyright © 2016年 heyuanbo. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "UIImage+category.h"
#import "UIImageChangeMethodViewController.h"
#import "NSArray+Person.h"
#import "User.h"

#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height
@interface ViewController ()

@end

@implementation ViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Runtime";
    [self creatTableViewAndDataSource];
}

#pragma mark - 创建tableview
- (void)creatTableViewAndDataSource {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, VIEW_WIDTH, VIEW_HEIGHT - 20) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.dataArray = [NSMutableArray arrayWithArray:@[@"发送消息",
                                                      @"获取Person类的所有属性和变量",
                                                      @"获取Person类的方法",
                                                      @"交换方法:拦截系统方法",
                                                      @"给Category增加属性",
                                                      @"字典转Model"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //发送消息
        [self sendMessage];
    } else if (indexPath.row == 1) {
        //获取Person类的所有属性和变量
        [self getPersonAllVaribal];
        
    } else if (indexPath.row == 2) {
        //获取Person类的方法
        [self getPersonMethod];

    } else if (indexPath.row == 3) {
        UIImageChangeMethodViewController *controller = [[UIImageChangeMethodViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        
    } else if (indexPath.row == 4) {
        //为category添加属性
        //查看文件 NSArray+Person.m 文件
        NSArray *array = @[@"Magic", @"Unique"];
        Person *person = [Person new];
        array.person = person;
        NSLog(@"为category添加属性：%@", array.person);
    } else if (indexPath.row == 5) {
        NSString *dictionary = @{@"name": @"heyuanbo",@"as":@"www", @"homeAddress": @"China", @"weight":@120, @"user":@{@"name":@"fengmeiling"}};
        User *user = [User exchangeUserModelWithDictionary:dictionary];
        NSLog(@"%@,%@,%@,%@,%@", user, user.name, user.homeAddress, user.age, user.weight);
    } else if (indexPath.row == 6) {
        
    } else {
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 发送消息
- (void)sendMessage {
    Person *person = [[Person alloc] init];
    objc_msgSend(person, @selector(instanceRun));
}

#pragma mark - 获取Person类的所有属性和变量
- (void)getPersonAllVaribal {
    unsigned int outCount = 0;
    /*
     *class_copyPropertyList返回的仅仅是对象类的属性(@property申明的属性)
     *class_copyIvarList返回类的所有属性和变量(包括在@interface大括号中声明的变量)
     */
    Ivar *ivars = class_copyIvarList([Person class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"获取类的属性和变量~~变量名：%s 成员变量类型：%s",name,type);
    }
}

#pragma mark - 获取Person类的方法
- (void)getPersonMethod {
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList([Person class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Method method = methodList[i];
        NSString *name = NSStringFromSelector(method_getName(method));
        NSLog(@"获取类的方法~~方法名:%@", name);
    }
}

@end
