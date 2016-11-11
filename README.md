# WW-Runingtime
Run time ,运行时，动态语言，
ios-runtime

如有任何问题和错误，请联系 heyuanbo11@163.com
runtime的重要作用：

    获取类的所有属性和类型：方便归档和解档，要不然得根据每个属性一个一个的归档，如果属性发生变化，那么如果归档方法不进行相应的改动就会崩溃，而如果使用runtime获取到所有的属性，那么就可以避免这种情况
    交换方法：如果我们一直在使用的某个方法，之后需求发生变化，在方法中要进行一些设置，那么我们可以重写一个方法，然后交换新旧方法，方便改动。
    为分类增加属性
    字典转模型：MJExtension、YYModel都是要用这个
    动态增加方法
    实现万能控制器的跳转：就是根据推送消息进来的页面需要变化

runtime使用
发送消息

#pragma mark - 发送消息
- (void)sendMessage {
    Person *person = [[Person alloc] init];
    objc_msgSend(person, @selector(instanceRun));
}

获取类的所有属性和变量

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

获取类的所有方法

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

交换方法、拦截系统方法

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

给Category增加属性

#import "NSArray+Person.h"
#import <objc/runtime.h>
@implementation NSArray (Person)

char *key;
- (void)setPerson:(Person *)person {
    objc_setAssociatedObject(self, key, person,     OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Person *)person {
    return objc_getAssociatedObject(self, key);
}
@end

字典转Model

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
