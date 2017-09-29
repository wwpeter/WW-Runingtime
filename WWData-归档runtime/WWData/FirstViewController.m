//
//  FirstViewController.m
//  WWData
//
//  Created by wangwei on 2017/9/29.
//  Copyright © 2017年 wangwei-WW. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end


@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViews];
    [self initViewConfigurations];
}
#pragma mark - initializations
/*
 *
 *
 XML属性列表(plist)归档
 Preference(偏好设置)
 NSKeyedArchiver归档(NSCoding)
 Documents
 Library/Perference  Library/Caches
 tep
 systemData
 */
- (void)but {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 64, 100, 30);
    [button setTitle:@"数据储存" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)click {
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)initViews {
    [self but];
    
    NSString *homePathStr = NSHomeDirectory();
    NSLog(@"homePathStr == %@",homePathStr);
    NSString *document = [homePathStr stringByAppendingString:@"/Documents"];
    NSLog(@"---document---%@",document);
    NSString *documents = [homePathStr stringByAppendingPathComponent:@"Documents"];
    NSLog(@"********* = %@",documents);
    
    NSString *tmp = NSTemporaryDirectory();
    NSLog(@"tmp======= %@",tmp);
    
    NSString *library = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"$$$$$$$$$$$$  %@",library);
    
    [[NSUserDefaults standardUserDefaults] setValue:@"value1" forKey:@"key1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key1"];
    NSLog(@"0000000 == %@",key);
    //plist文件的归档
    NSArray *arr = [[NSArray alloc] initWithObjects:@"王威", @"王威1", nil]; // NSDocumentDirectory 要查找的文件 // NSUserDomainMask 代表从用户文件夹下找 // 在iOS中，只有一个目录跟传入的参数匹配，所以这个集合里面只有一个元素
    NSDictionary *dic =@{
                         @"arr":arr,
                         @"dic":@"dic"
                         };
    NSString *path =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"test.plist"];
    [dic writeToFile:filePath atomically:YES];
    
    NSString *filePath1 = [path stringByAppendingPathComponent:@"test.plist"];
    NSDictionary *myDic = [NSDictionary dictionaryWithContentsOfFile:filePath1];
    NSLog(@"))))))) %@",myDic);
    
    NSDictionary *dict = @{
                           @"name" : @"刘德华",
                           @"age" : @58
                           };
    // 系统类NSDictionary的归档
    NSString *PATH = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *filePath2 = [PATH stringByAppendingPathComponent:@"DeHua.txt"]; // 后缀不一定这样写
    // NSKeyedArchiver归档类，负现把对象归档到本地文件
    // 第一个参数：要归档的对象
    // 第二个参数：归档到哪里（文件路径）
    BOOL success = [NSKeyedArchiver archiveRootObject:dict toFile:filePath2];
    if (success) {
        NSLog(@"归档成功");
    }
    
    // 解归档
    NSDictionary *dict2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath2];
    NSLog(@"%@", dict2);
    
    // Foundation系统的类 NSArray NSDictionary 都默认可以归档和解归档
    // 但是自定义的类要实现归档和解归档，就得遵守并实现<NSCoding>协议
    
}
- (void)initViewConfigurations {
    
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
