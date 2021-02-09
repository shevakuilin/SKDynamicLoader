//
//  AppDelegate.m
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/1/21.
//

#import "AppDelegate.h"
#import "A.h"
#import "NSMutableArray+variadicMethodExample.h"
#import "BridgeModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [A executeJSMethod:@"logWithContent:" moduleName:@"ViewController"];
//    NSString *value = [A executeJSReturnValueMethod:@"getValue" moduleName:@"ViewController"];
//    NSLog(@"value = %@", value);
//    [A executeJSVoidMethod:@"toDetailedWithVCName:hiddenBottom:width:height:" moduleName:@"ViewController" arguments:@"testVC", @"2",@"3",@"4", nil];
//    NSMutableArray *array = [NSMutableArray array];
//    [array appendObjects:@"1",@"2",@"3",@"4",nil];
    
//    CGFloat width = 25;
//    NSDictionary *data = @{@"alertTitle": @"洋葱标题",
//                           @"alertContent": @"大家好",
//                           @"confirmTitle": @"确定"};
//    [A executeJSVoidMethod:@"toDetailedWithVCName:hiddenBottom:width:data:" moduleName:@"ViewController" arguments:@[@"testVC", @(true), @(width), data]];
//    NSLog(@"!!");
    BridgeModel *model = [BridgeModel new];
    model.callId = @"asdasd3242dsafsdgsw5";
    model.callData = @{@"alertTitle": @"洋葱标题",
                       @"alertContent": @"大家好",
                       @"confirmTitle": @"确定"};
    model.eventName = @"calculateHeightWithModel:";
    model.moduleName = @"ViewController";
    NSNumber *heightN = [A executeJSReturnValueMethod:model.eventName moduleName:model.moduleName arguments:@[model]];
    CGFloat height = [heightN floatValue];
    NSLog(@"height = %.2f", height);

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
