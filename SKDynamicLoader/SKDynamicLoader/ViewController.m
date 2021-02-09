//
//  ViewController.m
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/1/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)classMethodTest1 {
    NSLog(@"执行%@", NSStringFromSelector(@selector(classMethodTest1)));
}

- (void)instanceMethodTest1 {
    NSLog(@"执行%@", NSStringFromSelector(@selector(instanceMethodTest1)));
}

+ (void)classMethodTest2 {
    NSLog(@"执行%@", NSStringFromSelector(@selector(classMethodTest2)));
}

- (void)instanceMethodTest2 {
    NSLog(@"执行%@", NSStringFromSelector(@selector(instanceMethodTest2)));
}

- (void)logWithContent:(NSString *)content {
    NSLog(@"logWithContent:%@", content);
}

- (NSString *)getValue {
    NSLog(@"执行getValue");
    return @"Value";
}

- (void)toDetailedWithVCName:(NSString *)vcName hiddenBottom:(BOOL)hiddenBottom width:(CGFloat)width data:(NSDictionary *)data {
    NSLog(@"vcName = %@, hiddenBottom = %@, width = %.2f, data = %@", vcName, hiddenBottom?@"true":@"false", width, data);
}

@end
