//
//  A.m
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/1/21.
//

#import "A.h"
#import <objc/runtime.h>
//#import "ViewController.h"

@implementation A

#pragma mark - Public

+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName {
    Class class = NSClassFromString(moduleName);
    // 判断该类是否存在
    if (class) {
        SEL sel = NSSelectorFromString(methodName);
        if ([class instancesRespondToSelector:sel]) { // 实例方法
            IMP imp = [class instanceMethodForSelector:sel];
            // 执行
            ((void(*)(void))imp)();
        } else if ([class respondsToSelector:sel]) { // 类方法
            IMP imp = [class methodForSelector:sel];
            // 执行
            ((void(*)(void))imp)();
//            ((id(*)(id, SEL, UIView*, id))imp)(self, sel, [UIView new], @"DFD");
        }
    }
}

+ (id)executeJSReturnValueMethod:(NSString *)methodName moduleName:(NSString *)moduleName {
    Class class = NSClassFromString(moduleName);
    // 判断该类是否存在
    if (class) {
        SEL sel = NSSelectorFromString(methodName);
        if ([class instancesRespondToSelector:sel]) { // 实例方法
            IMP imp = [class instanceMethodForSelector:sel];
            // 执行
            return ((id(*)(id, SEL, id))imp)(self, sel, [class new]);
        } else if ([class respondsToSelector:sel]) { // 类方法
            IMP imp = [class methodForSelector:sel];
            // 执行
            return ((id(*)(id, SEL, id))imp)(self, sel, [class new]);
        }
    }
    return nil;
}

#pragma mark - Private

// 打印方法列表
//+ (void)printMethodList {
//    unsigned int count;
//    
//    Method *methodList = class_copyMethodList([ViewController class], &count);
//    for (unsigned int i = 0; i < count; i++) {
//        Method method = methodList[i];
//        NSLog(@"instanceMethod : %@", NSStringFromSelector(method_getName(method)));
//    }
//    Method *classMethodList = class_copyMethodList(object_getClass([ViewController class]), &count);
//    for (unsigned int i = 0; i < count; i++) {
//        Method classMethod = classMethodList[i];
//        NSLog(@"classMethod : %@", NSStringFromSelector(method_getName(classMethod)));
//    }
//    
//    free(methodList);
//}

@end
