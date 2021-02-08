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

+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName arguments:(id)arg1,...NS_REQUIRES_NIL_TERMINATION {
    Class class = NSClassFromString(moduleName);
    // 判断该类是否存在
    if (class) {
        SEL sel = NSSelectorFromString(methodName);
        if ([class instancesRespondToSelector:sel]) { // 实例方法
            IMP imp = [class instanceMethodForSelector:sel];
            // 参数列表指针
            va_list args;
            // 获取第一个可选参数的地址，使参数列表指针指向函数参数列表中的第一个可选参数
            va_start(args, arg1);
//            if (arg1) {
//                // 依次取得除第一个参数以外的参数
//                // 获取可变参数的当前参数，返回指定类型并将指针指向下一参数
//                while (va_arg(args, id)) {
//                    id otherArg = va_arg(args, id);
//                    NSLog(@"otherString %@", otherArg);
//                }
//            }
            ((void(*)(id, SEL, id,...))imp)(self, sel, arg1);
            // 清空参数列表，并置参数指针args无效。
            va_end(args);
        } else if ([class respondsToSelector:sel]) { // 类方法
            IMP imp = [class methodForSelector:sel];
            // 参数列表指针
            va_list args;
            // 获取第一个可选参数的地址，使参数列表指针指向函数参数列表中的第一个可选参数
            va_start(args, arg1);
            // 执行
            ((void(*)(id, SEL, id,...))imp)(self, sel, va_arg(args, id));
            // 清空参数列表，并置参数指针args无效。
            va_end(args);
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
            return ((id(*)(id, SEL))imp)(self, sel);
        } else if ([class respondsToSelector:sel]) { // 类方法
            IMP imp = [class methodForSelector:sel];
            // 执行
            return ((id(*)(id, SEL))imp)(self, sel);
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
