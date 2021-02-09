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

//+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName arguments:(id)arg1, ...NS_REQUIRES_NIL_TERMINATION {
//    Class class = NSClassFromString(moduleName);
//    // 判断该类是否存在
//    if (class) {
//        SEL sel = NSSelectorFromString(methodName);
//        if ([class instancesRespondToSelector:sel]) { // 实例方法
////            IMP imp = [class instanceMethodForSelector:sel];
//            if (arg1) {
//                Method method = class_getInstanceMethod(class, sel);
//                unsigned int count = method_getNumberOfArguments(method);
//
//                id instanceObjc = [class new];
//                NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[instanceObjc methodSignatureForSelector:sel]];
//                [inv setSelector:sel];
//                [inv setTarget:instanceObjc];
//                // 添加第一个参数
//                [inv setArgument:&(arg1) atIndex:2];
//
//                id eachObject;
//                // 参数列表指针
//                va_list args;
//                // 获取第一个可选参数的地址，使参数列表指针指向函数参数列表中的第一个可选参数
//                va_start(args, arg1);
//                int i = 3;
//                while ((eachObject = va_arg(args, id))) // As many times as we can get an argument of type "id"
//                    [inv setArgument:&(eachObject) atIndex:i];
//                    i++;
////                // 添加剩余参数
////                for (int i = 3; i < count; i++) {
////                    // 获取可变参数的当前参数，返回指定类型并将指针指向下一参数
////                    id otherArg = va_arg(args, id);
////                    [inv setArgument:&(otherArg) atIndex:i];
////                }
//                // 方法调用
//                [inv invoke];
//                // 清空参数列表，并置参数指针args无效。
//                va_end(args);
//
//                // 依次取得除第一个参数以外的参数
//                // 获取可变参数的当前参数，返回指定类型并将指针指向下一参数
////                while (va_arg(args, id)) {
////                    id otherArg = va_arg(args, id);
////                    NSLog(@"otherString %@", otherArg);
////                }
//            }
////            ((void(*)(id, SEL, id,...))imp)(self, sel, arg1);
////                        id instanceObjc = [class new];
////            NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[instanceObjc methodSignatureForSelector:sel]];
////            [inv setSelector:sel];
////            [inv setTarget:instanceObjc];
//
////            [inv setArgument:&(indexPath) atIndex:2]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
////            [inv setArgument:&(dataSource) atIndex:3]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
//
////            [inv invoke];
//
//        } else if ([class respondsToSelector:sel]) { // 类方法
//            IMP imp = [class methodForSelector:sel];
//            // 参数列表指针
//            va_list args;
//            // 获取第一个可选参数的地址，使参数列表指针指向函数参数列表中的第一个可选参数
//            va_start(args, arg1);
//            // 执行
//            ((void(*)(id, SEL, id,...))imp)(self, sel, va_arg(args, id));
//            // 清空参数列表，并置参数指针args无效。
//            va_end(args);
//        }
//    }
//}

+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName arguments:(NSArray *)arguments {
    Class class = NSClassFromString(moduleName);
    // 判断该类是否存在
    if (class) {
        SEL sel = NSSelectorFromString(methodName);
        if ([class instancesRespondToSelector:sel]) { // 实例方法
            Method method = class_getInstanceMethod(class, sel);
            unsigned int count = method_getNumberOfArguments(method);
            // 参数存在，且参数数量与方法提供的入参数量相同
            if (arguments.count > 0 && (arguments.count + 2) == count) {
                id instanceObjc = [class new];
                NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[instanceObjc methodSignatureForSelector:sel]];
                [inv setSelector:sel];
                [inv setTarget:instanceObjc];
                for (int i = 0; i < arguments.count; i++) {
                    id arg = arguments[i];
                    [A setArgumenWithInvocation:inv index:i + 2 value:arg];
                }
                // 方法调用
                [inv invoke];
            }
        } else if ([class respondsToSelector:sel]) { // 类方法
            Method method = class_getClassMethod(class, sel);
            unsigned int count = method_getNumberOfArguments(method);
            // 参数存在，且参数数量与方法提供的入参数量相同
            if (arguments.count > 0 && (arguments.count + 2) == count) {
                id instanceObjc = [class new];
                NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[instanceObjc methodSignatureForSelector:sel]];
                [inv setSelector:sel];
                [inv setTarget:instanceObjc];
                for (int i = 0; i < arguments.count; i++) {
                    id arg = arguments[i];
                    [A setArgumenWithInvocation:inv index:i + 2 value:arg];
                }
                // 方法调用
                [inv invoke];
            }
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

+ (void)setArgumenWithInvocation:(NSInvocation *)inv index:(int)index value:(id)value {
    // - Note: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *numberValue = (NSNumber *)value;
        const char *objCType = [((NSNumber*)value) objCType];
        if (strcmp(objCType, @encode(float)) == 0) {
            float f = [numberValue floatValue];
            [inv setArgument:&(f) atIndex:index];
        } else if (strcmp(objCType, @encode(double))  == 0) {
            double d = [numberValue doubleValue];
            [inv setArgument:&(d) atIndex:index];
        } else if (strcmp(objCType, @encode(int))  == 0) {
            int i = [numberValue intValue];
            [inv setArgument:&(i) atIndex:index];
        } else if (strcmp(objCType, @encode(BOOL)) == 0 || strcmp(objCType, @encode(Boolean)) == 0) {
            BOOL b = [numberValue boolValue];
            [inv setArgument:&(b) atIndex:index];
        } else if (strcmp(objCType, @encode(CFStringRef)) == 0 || strcmp(objCType, @encode(NSString)) == 0) {
            NSString *s = [numberValue stringValue];
            [inv setArgument:&(s) atIndex:index];
        } else {
            [inv setArgument:&(value) atIndex:index];
        }
    } else {
        [inv setArgument:&(value) atIndex:index];
    }
}

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
